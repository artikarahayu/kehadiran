// edit_absensi.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditAbsensiScreen extends StatefulWidget {
  final Map<String, dynamic> absensiData;

  const EditAbsensiScreen({super.key, required this.absensiData});

  @override
  State<EditAbsensiScreen> createState() => _EditAbsensiScreenState();
}

class _EditAbsensiScreenState extends State<EditAbsensiScreen> {
  late TextEditingController _namaController;
  String? _selectedStatus;
  final List<String> _statusList = ['Hadir', 'Tidak Hadir'];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.absensiData['nama']);
    _selectedStatus = widget.absensiData['status'];
  }

  Future<void> _updateAbsensi() async {
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
      final id = widget.absensiData['id'];

      await Supabase.instance.client
          .from('absensi')
          .update({'nama': nama, 'status': status})
          .eq('id', id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil mengubah absensi')),
        );
        Navigator.pop(context, true); // kembalikan tanda berhasil update
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal mengubah absensi: $e')));
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
        title: const Text('Edit Absensi'),
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
              onPressed: _isLoading ? null : _updateAbsensi,
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
                      : const Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}
