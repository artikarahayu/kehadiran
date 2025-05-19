import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //untuk format waktu

class SuksesScreen extends StatelessWidget {
  final DateTime waktu; //waktu yang diambil

  const SuksesScreen({
    super.key,
    required this.waktu,
  }); //konstruktor dengan waktu sebagai parameter

  @override
  Widget build(BuildContext context) {
    final String formattedWaktu = DateFormat(
      'dd MMMM yyyy, HH:mm',
    ).format(waktu); //format waktu menjadi string
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF08B93),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                child: const Text(
                  'ANDA SUDAH MENGISI KEHADIRAN',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Waktu Absen:\n$formattedWaktu',
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'Anda hanya dapat mengisi kehadiran ini sekali.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'TERIMA KASIH TELAH MENGISI KEHADIRAN',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
