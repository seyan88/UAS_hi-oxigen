import 'package:flutter/material.dart';
import 'kelola_pertemuan_page.dart'; // Import halaman pertemuan

class KelolaPeriodePage extends StatefulWidget {
  const KelolaPeriodePage({super.key});

  @override
  State<KelolaPeriodePage> createState() => _KelolaPeriodePageState();
}

class _KelolaPeriodePageState extends State<KelolaPeriodePage> {
  final Color navyOxigen = const Color(0xFF0D1B3E);
  final Color blueOxigen = const Color(0xFF2E5BFF);

  // Data Dummy Periode
  List<Map<String, dynamic>> _daftarPeriode = [
    {
      "nama": "Semester Genap 2025/2026",
      "mulai": "28/01/2026",
      "selesai": "28/12/2026",
      "pertemuan": ["Pertemuan 1", "Pertemuan 2"] // List pertemuan di dalamnya
    },
    {
      "nama": "Pelatihan BPH",
      "mulai": "17/01/2026",
      "selesai": "31/01/2026",
      "pertemuan": []
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Kelola Periode", style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: navyOxigen,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFormTambahPeriode(),
            const SizedBox(height: 20),
            _buildTablePeriode(),
          ],
        ),
      ),
    );
  }

  // WIDGET: Form Tambah Periode (Bagian Atas Gambar)
  Widget _buildFormTambahPeriode() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Tambah Periode Baru", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),
            _buildField("Nama Periode", "Contoh: Semester Genap 2025/2026"),
            Row(
              children: [
                Expanded(child: _buildField("Tanggal Mulai", "mm / dd / yyyy", isDate: true)),
                const SizedBox(width: 10),
                Expanded(child: _buildField("Tanggal Selesai", "mm / dd / yyyy", isDate: true)),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: blueOxigen, foregroundColor: Colors.white),
              child: const Text("Tambah Periode"),
            )
          ],
        ),
      ),
    );
  }

  // WIDGET: Daftar Periode (Bagian Bawah Gambar)
  Widget _buildTablePeriode() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text("Daftar Periode", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          const Divider(height: 1),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _daftarPeriode.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = _daftarPeriode[index];
              return ListTile(
                title: Text(item['nama'], style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${item['mulai']} - ${item['selesai']}"),
                    Text("${item['pertemuan'].length} Pertemuan", style: TextStyle(color: blueOxigen, fontWeight: FontWeight.bold)),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Tombol Kelola Pertemuan -> Pindah Halaman
                    ElevatedButton(
                      onPressed: () async {
                        // Navigasi ke halaman detail dan tunggu hasilnya
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KelolaPertemuanPage(
                              namaPeriode: item['nama'],
                              pertemuanAwal: List<String>.from(item['pertemuan']),
                            ),
                          ),
                        );
                        // Update jumlah pertemuan jika ada perubahan
                        if (result != null) {
                          setState(() {
                            _daftarPeriode[index]['pertemuan'] = result;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: blueOxigen, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 8)),
                      child: const Text("Kelola Pertemuan", style: TextStyle(fontSize: 11)),
                    ),
                    const SizedBox(width: 5),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.delete, color: Colors.red)),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildField(String label, String hint, {bool isDate = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          TextField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(fontSize: 13),
              suffixIcon: isDate ? const Icon(Icons.calendar_month, size: 18) : null,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }
}