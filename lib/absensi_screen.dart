import 'package:flutter/material.dart';

class AbsensiScreen extends StatefulWidget {
  const AbsensiScreen({super.key});

  @override
  State<AbsensiScreen> createState() => _AbsensiScreenState();
}

class _AbsensiScreenState extends State<AbsensiScreen> {
  final List<String> namaList = [
    'Artika Rahayu',
    'Arwidya Diestyana',
  ]; // opsi nama
  final List<String> isiList = ['Hadir', 'Tidak Hadir']; // opsi kehadiran

  String? selectedNama; // nama yang dipilih
  String? selectedIsi; // isi kehadiran yang dipilih

  // fungsi saat klik tombol
  void _konfirmasi() {
    if (selectedNama != null && selectedIsi != null) {
      final DateTime waktuAbsen = DateTime.now(); //mengambil waktu saat ini
      Navigator.push(
        // pindah ke halaman sukses
        context,
        MaterialPageRoute(
          builder:
              (context) => const SuksesScreen(
                waktu: waktuAbsen, //waktu absen yang diambil
              ),
        ),
      );
    }
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

              DropdownButtonFormField<String>(
                value: selectedNama, // nilai awal dropdown
                items:
                    namaList
                        .map(
                          (nama) =>
                              DropdownMenuItem(value: nama, child: Text(nama)),
                        )
                        .toList(),
                decoration: const InputDecoration(
                  labelText: 'Nama Kehadiran', // label input
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  setState(() {
                    selectedNama = value; // simpan pilihan
                  });
                },
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
