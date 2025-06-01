import 'package:flutter/material.dart';
import 'sukses_screen.dart'; // menambahkan import halaman sukses

class AbsensiScreen extends StatefulWidget {
  const AbsensiScreen({super.key});

  @override
  State<AbsensiScreen> createState() => _AbsensiScreenState();
}

class _AbsensiScreenState extends State<AbsensiScreen> {
  final List<String> isiList = ['Hadir', 'Tidak Hadir']; // opsi kehadiran
  final TextEditingController _namaController =
      TextEditingController(); // controller untuk input nama

  String? selectedIsi; // isi kehadiran yang dipilih

  // fungsi saat klik tombol
  void _konfirmasi() {
    final String nama =
        _namaController.text.trim(); // ambil dan bersihkan input nama

    if (nama.isNotEmpty && selectedIsi != null) {
      final DateTime waktuAbsen = DateTime.now(); //mengambil waktu saat ini
      Navigator.push(
        // pindah ke halaman sukses
        context,
        MaterialPageRoute(
          builder:
              (context) => SuksesScreen(
                waktu: waktuAbsen, // waktu absen yang diambil
              ),
        ),
      );
    } else {
      // tampilkan snackbar jika belum lengkap
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan isi nama dan pilih kehadiran')),
      );
    }
  }

  @override
  void dispose() {
    _namaController.dispose(); // bersihkan controller saat widget dihancurkan
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // isi tengah
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // posisi tengah
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF08B93), // warna pink
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'Absensi Kehadiran', // judul
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
                  labelText: 'Nama Kehadiran', // label input
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value: selectedIsi, // nilai awal dropdown
                items:
                    isiList
                        .map(
                          (isi) =>
                              DropdownMenuItem(value: isi, child: Text(isi)),
                        )
                        .toList(),
                decoration: const InputDecoration(
                  labelText: 'Isi Kehadiran', // label input
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  setState(() {
                    selectedIsi = value; // simpan pilihan
                  });
                },
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _konfirmasi, // panggil fungsi konfirmasi
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF08B93), // warna tombol
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Konfirmasi Absensi'), // teks tombol
              ),
            ],
          ),
        ),
      ),
    );
  }
}
