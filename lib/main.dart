// main.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'absensi_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://fveomzyswvehjsrqqgoo.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ2ZW9tenlzd3ZlaGpzcnFxZ29vIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg3NTMwNDEsImV4cCI6MjA2NDMyOTA0MX0.YU3KbaVjBTQjE19KijMoUYSy5Iy63eVcpDFS233PmTc',
  );

  runApp(const AbsensiApp());
}

class AbsensiApp extends StatelessWidget {
  const AbsensiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Absensi Kehadiran',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF08B93),
          foregroundColor: Colors.black,
        ),
      ),
      home: const AbsensiScreen(),
    );
  }
}
