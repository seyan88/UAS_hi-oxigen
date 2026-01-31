import 'package:flutter/material.dart';

class KelolaPertemuanPage extends StatefulWidget {
  final String namaPeriode;
  final List<String> pertemuanAwal;

  const KelolaPertemuanPage({super.key, required this.namaPeriode, required this.pertemuanAwal});

  @override
  State<KelolaPertemuanPage> createState() => _KelolaPertemuanPageState();
}

class _KelolaPertemuanPageState extends State<KelolaPertemuanPage> {
  final Color navyOxigen = const Color(0xFF0D1B3E);
  late List<String> _listPertemuan;

  @override
  void initState() {
    super.initState();
    _listPertemuan = widget.pertemuanAwal;
  }

  void _tambahPertemuan() {
    setState(() {
      _listPertemuan.add("Pertemuan ${_listPertemuan.length + 1}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Atur Pertemuan", style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: navyOxigen,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, _listPertemuan), // Kirim balik data yang diupdate
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.namaPeriode, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            
            // Tombol Tambah
            ElevatedButton.icon(
              onPressed: _tambahPertemuan,
              icon: const Icon(Icons.add),
              label: const Text("Tambah Pertemuan"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
            ),
            
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _listPertemuan.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: navyOxigen,
                        child: Text("${index + 1}", style: const TextStyle(color: Colors.white)),
                      ),
                      title: Text(_listPertemuan[index]),
                      subtitle: const Text("Klik untuk atur tanggal"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () {
                          setState(() => _listPertemuan.removeAt(index));
                        },
                      ),
                      onTap: () {
                        // Logika DatePicker bisa ditaruh di sini
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}