import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Tambahkan package intl di pubspec.yaml untuk format tanggal
import 'kelola_pertemuan_page.dart';

class KelolaPeriodePage extends StatefulWidget {
  const KelolaPeriodePage({super.key});

  @override
  State<KelolaPeriodePage> createState() => _KelolaPeriodePageState();
}

class _KelolaPeriodePageState extends State<KelolaPeriodePage> {
  final Color navyOxigen = const Color(0xFF0D1B3E); //
  final Color blueOxigen = const Color(0xFF2E5BFF); //

  // Controller untuk menangkap input tanggal
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _mulaiController = TextEditingController();
  final TextEditingController _selesaiController = TextEditingController();

  List<Map<String, dynamic>> _daftarPeriode = [
    {
      "nama": "Semester Genap 2025/2026",
      "mulai": "28/01/2026",
      "selesai": "28/12/2026",
      "pertemuan": ["Pertemuan 1", "Pertemuan 2"]
    },
  ];

  // FUNGSI: Menampilkan Kalender
  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: navyOxigen), // Warna kalender sesuai brand
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        // Format tanggal: dd/MM/yyyy
        controller.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

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
          children: [
            _buildFormTambahPeriode(),
            const SizedBox(height: 20),
            _buildTablePeriode(),
          ],
        ),
      ),
    );
  }

  Widget _buildFormTambahPeriode() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Tambah Periode Baru", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),
            
            // Input Nama
            _buildTextField("Nama Periode", "Contoh: Semester Genap 2025/2026", _namaController, false),
            
            // Row Tanggal Mulai & Selesai
            Row(
              children: [
                Expanded(
                  child: _buildTextField("Tanggal Mulai", "dd/mm/yyyy", _mulaiController, true),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTextField("Tanggal Selesai", "dd/mm/yyyy", _selesaiController, true),
                ),
              ],
            ),
            
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // --- KONEKSI DATABASE ---
                  // FirebaseFirestore.instance.collection('periode').add({ ... });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: blueOxigen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Tambah Periode"),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget TextField yang bisa mendeteksi klik tanggal
  Widget _buildTextField(String label, String hint, TextEditingController controller, bool isDate) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            readOnly: isDate, // Jika tanggal, user tidak bisa ngetik manual
            onTap: isDate ? () => _selectDate(context, controller) : null,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
              suffixIcon: isDate ? Icon(Icons.calendar_month, size: 18, color: navyOxigen) : null,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              filled: true,
              fillColor: isDate ? Colors.grey[50] : Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTablePeriode() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text("Daftar Periode", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          const Divider(height: 1),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _daftarPeriode.length,
            itemBuilder: (context, index) {
              final item = _daftarPeriode[index];
              return ListTile(
                title: Text(item['nama'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: Text("${item['mulai']} - ${item['selesai']}\n${item['pertemuan'].length} Pertemuan", 
                  style: const TextStyle(fontSize: 12)),
                isThreeLine: true,
                trailing: ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KelolaPertemuanPage(
                          namaPeriode: item['nama'],
                          pertemuanAwal: List<String>.from(item['pertemuan']),
                        ),
                      ),
                    );
                    if (result != null) setState(() => _daftarPeriode[index]['pertemuan'] = result);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: blueOxigen, foregroundColor: Colors.white),
                  child: const Text("Kelola", style: TextStyle(fontSize: 10)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}