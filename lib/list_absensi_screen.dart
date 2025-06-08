// list_absensi_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'edit_absensi.dart';
import 'add_absensi.dart';

class ListAbsensiScreen extends StatefulWidget {
  const ListAbsensiScreen({super.key});

  @override
  State<ListAbsensiScreen> createState() => _ListAbsensiScreenState();
}

class _ListAbsensiScreenState extends State<ListAbsensiScreen> {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _absensiList = [];
  bool _isLoading = false;

  Future<void> _fetchAbsensi() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await supabase
          .from('absensi')
          .select()
          .order('waktu', ascending: false);

      setState(() {
        _absensiList = List<Map<String, dynamic>>.from(response);
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _hapusAbsensi(int id) async {
    try {
      final response = await supabase.from('absensi').delete().eq('id', id);

      // Jika berhasil, response berisi list data yang terhapus
      if (response != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Data berhasil dihapus')));
        _fetchAbsensi();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Gagal menghapus data')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
    }
  }

  void _navigateToAdd() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddAbsensiScreen()),
    );

    if (result == true) {
      _fetchAbsensi();
    }
  }

  void _navigateToEdit(Map<String, dynamic> absensiData) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditAbsensiScreen(absensiData: absensiData),
      ),
    );

    if (result == true) {
      _fetchAbsensi();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchAbsensi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Absensi'),
        backgroundColor: const Color(0xFFF08B93),
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _absensiList.isEmpty
              ? const Center(child: Text('Belum ada data absensi'))
              : ListView.builder(
                itemCount: _absensiList.length,
                itemBuilder: (context, index) {
                  final absensi = _absensiList[index];
                  final waktu = DateTime.parse(absensi['waktu']);
                  final formattedWaktu =
                      '${waktu.day.toString().padLeft(2, '0')}-${waktu.month.toString().padLeft(2, '0')}-${waktu.year} ${waktu.hour.toString().padLeft(2, '0')}:${waktu.minute.toString().padLeft(2, '0')}';

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      title: Text(absensi['nama']),
                      subtitle: Text(
                        'Status: ${absensi['status']}\nWaktu: $formattedWaktu',
                      ),
                      isThreeLine: true,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _navigateToEdit(absensi),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed:
                                () => showDialog(
                                  context: context,
                                  builder:
                                      (context) => AlertDialog(
                                        title: const Text('Konfirmasi Hapus'),
                                        content: const Text(
                                          'Yakin ingin menghapus data ini?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              _hapusAbsensi(absensi['id']);
                                            },
                                            child: const Text('Hapus'),
                                          ),
                                          TextButton(
                                            onPressed:
                                                () => Navigator.pop(context),
                                            child: const Text('Batal'),
                                          ),
                                        ],
                                      ),
                                ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAdd,
        backgroundColor: const Color(0xFFF08B93),
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
