import 'package:flutter/material.dart';

class SuksesScreen extends StatelessWidget {
  const SuksesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // isi tengah
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(20), // padding dalam box
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5), // warna box
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'ANDA SUDAH MENGISI KEHADIRAN', // judul
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                Text(
                  'Anda hanya dapat mengisi kehadiran ini sekali.\n\nTERIMA KASIH TELAH MENGISI KEHADIRAN', // info kehadiran
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
