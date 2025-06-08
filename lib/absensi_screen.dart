// absensi_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'sukses_screen.dart';
import 'list_absensi_screen.dart';

class AbsensiScreen extends StatefulWidget {
  const AbsensiScreen({super.key});

  @override
  State<AbsensiScreen> createState() => _AbsensiScreenState();
}

class _AbsensiScreenState extends State<AbsensiScreen> {
  final List<String> isiList = ['Hadir', 'Tidak Hadir'];
  final TextEditingController _namaController = TextEditingController();
  String? selectedIsi;

  Future<void> _konfirmasi() async {
    final String nama = _namaController.text.trim();

    if (nama.isNotEmpty && selectedIsi != null) {
      final DateTime waktuAbsen = DateTime.now();

      try {
        await Supabase.instance.client.from('absensi').insert({
          'nama': nama,
          'waktu': waktuAbsen.toIso8601String(),
          'status': selectedIsi,
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuksesScreen(waktu: waktuAbsen, nama: nama),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal menyimpan absensi: $e')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan isi nama dan pilih kehadiran')),
      );
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF08B93),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'Absensi Kehadiran',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Kehadiran',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedIsi,
                items:
                    isiList
                        .map(
                          (isi) =>
                              DropdownMenuItem(value: isi, child: Text(isi)),
                        )
                        .toList(),
                decoration: const InputDecoration(
                  labelText: 'Isi Kehadiran',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  setState(() {
                    selectedIsi = value;
                  });
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _konfirmasi,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF08B93),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Konfirmasi Absensi'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ListAbsensiScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                ),
                child: const Text('Lihat Daftar Absensi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
