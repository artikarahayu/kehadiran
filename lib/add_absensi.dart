import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddAbsensiScreen extends StatefulWidget {
  const AddAbsensiScreen({super.key});

  @override
  State<AddAbsensiScreen> createState() => _AddAbsensiScreenState();
}

class _AddAbsensiScreenState extends State<AddAbsensiScreen> {
  final TextEditingController _namaController = TextEditingController();
  String? _selectedStatus;
  final List<String> _statusList = ['Hadir', 'Tidak Hadir'];

  bool _isLoading = false;

  Future<void> _saveAbsensi() async {
    final String nama = _namaController.text.trim();
    final String? status = _selectedStatus;

    if (nama.isEmpty || status == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan isi nama dan pilih status')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final waktu = DateTime.now().toIso8601String();

      await Supabase.instance.client.from('absensi').insert({
        'nama': nama,
        'waktu': waktu,
        'status': status,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil menambah absensi')),
        );
        Navigator.pop(context, true); // bisa return true sebagai tanda refresh
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menyimpan absensi: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
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
      appBar: AppBar(
        title: const Text('Tambah Absensi'),
        backgroundColor: const Color(0xFFF08B93),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              items:
                  _statusList
                      .map(
                        (status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ),
                      )
                      .toList(),
              decoration: const InputDecoration(
                labelText: 'Status Kehadiran',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value;
                });
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isLoading ? null : _saveAbsensi,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF08B93),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
              ),
              child:
                  _isLoading
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Text('Simpan Absensi'),
            ),
          ],
        ),
      ),
    );
  }
}
