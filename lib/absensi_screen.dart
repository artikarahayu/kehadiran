import 'package:flutter/material.dart';

class AbsensiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Absensi Screen')),
      body: Center(
        child: Text(
          'Welcome to Absensi Screen',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: AbsensiScreen()));
}
