import 'package:flutter/material.dart';
import 'absensi_screen.dart'; //import halaman absensi

void main() {
  runApp(const AbsensiApp()); //menjalankan aplikasi
}

class AbsensiApp extends StatelessWidget {
  //membuat class AbsensiApp
  const AbsensiApp({super.key}); //constructor AbsensiApp

  @override
  Widget build(BuildContext context) {
    //method build untuk membuat tampilan
    return MaterialApp(
      //menggunakan MaterialApp untuk tampilan material design
      title: 'Absensi Kehadiran', //judul aplikasi
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //mengatur tema aplikasi
        scaffoldBackgroundColor: const Color(0xFFFAFAFA), //warna latar belakang
        useMaterial3: true, //menggunakan material 3
      ),
      home: const AbsensiScreen(), //menampilkan halaman utama AbsensiScreen
    );
  }
}
