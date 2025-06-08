import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SuksesScreen extends StatelessWidget {
  final DateTime waktu;
  final String nama;

  const SuksesScreen({super.key, required this.waktu, required this.nama});

  @override
  Widget build(BuildContext context) {
    final String formatted = DateFormat('dd MMM yyyy, HH:mm').format(waktu);

    return Scaffold(
      appBar: AppBar(title: const Text('Absensi Sukses')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 80, color: Colors.green),
              const SizedBox(height: 24),
              const Text(
                'Terima kasih!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                '$nama telah berhasil melakukan absensi.',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Waktu: $formatted',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF08B93),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                ),
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
