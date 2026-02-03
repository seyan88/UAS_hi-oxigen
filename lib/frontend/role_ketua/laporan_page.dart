import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'; // Buka untuk koneksi Firebase

class LaporanPage extends StatefulWidget {
  const LaporanPage({super.key});

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  // Warna Identitas Oxigen
  final Color navyOxigen = const Color(0xFF0D1B3E);
  final Color blueOxigen = const Color(0xFF2E5BFF);

  // Variabel State untuk Dropdown
  String? _selectedPeriode;
  String _selectedAngkatan = "Semua Angkatan";
  String _selectedBulan = "Semua Bulan";
  String _selectedTahun = "2026";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Background abu-abu terang
      appBar: AppBar(
        title: const Text("Laporan", style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: navyOxigen,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildParameterCard(),
            const SizedBox(height: 20),
            _buildPetunjukCard(),
          ],
        ),
      ),
    );
  }

  // --- WIDGET 1: PARAMETER LAPORAN ---
  Widget _buildParameterCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Parameter Laporan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const Divider(height: 30),

            // Dropdown Periode (Required)
            _buildLabel("Periode", isRequired: true),
            _buildDropdown(
              hint: "-- Pilih Periode --",
              value: _selectedPeriode,
              items: ["Semester Genap 2025/2026", "Pelatihan BPH", "Semester Ganjil 2025/2026"], // --- FIREBASE: Ambil dari collection 'periode' ---
              onChanged: (val) => setState(() => _selectedPeriode = val),
            ),

            // Dropdown Angkatan
            _buildLabel("Angkatan (Opsional)"),
            _buildDropdown(
              value: _selectedAngkatan,
              items: ["Semua Angkatan", "2022", "2023", "2024", "2025"], // --- FIREBASE: Ambil unik dari collection 'mahasiswa' ---
              onChanged: (val) => setState(() => _selectedAngkatan = val!),
            ),

            // Dropdown Bulan
            _buildLabel("Bulan (Opsional)"),
            _buildDropdown(
              value: _selectedBulan,
              items: ["Semua Bulan", "Januari", "Februari", "Maret", "April", "Mei", "Juni"], 
              onChanged: (val) => setState(() => _selectedBulan = val!),
            ),

            // Dropdown Tahun
            _buildLabel("Tahun (Opsional)"),
            _buildDropdown(
              value: _selectedTahun,
              items: ["2024", "2025", "2026", "2027"],
              onChanged: (val) => setState(() => _selectedTahun = val!),
            ),

            const SizedBox(height: 15),

            // Blue Info Box (Catatan)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.blue[100]!),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.blue, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Catatan: Laporan akan menampilkan data absensi yang sudah diapprove. Jika memilih bulan dan tahun, hanya pertemuan pada bulan/tahun tersebut yang akan ditampilkan.",
                      style: TextStyle(fontSize: 12, color: Colors.blue[900]),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Button Generate PDF
            ElevatedButton.icon(
              onPressed: () {
                // --- LOGIKA FIREBASE & PDF ---
                // 1. Query Firestore berdasarkan _selectedPeriode, _selectedAngkatan, dll.
                // 2. Gunakan package 'pdf' dan 'printing' untuk membuat file.
                print("Generating PDF for: $_selectedPeriode");
              },
              icon: const Icon(Icons.picture_as_pdf, size: 18),
              label: const Text("Generate PDF"),
              style: ElevatedButton.styleFrom(
                backgroundColor: blueOxigen,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET 2: PETUNJUK ---
  Widget _buildPetunjukCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Petunjuk", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),
            _instructionItem("1. Pilih periode yang akan dilaporkan"),
            _instructionItem("2. Pilih angkatan jika ingin laporan per angkatan (opsional)"),
            _instructionItem("3. Pilih bulan dan tahun jika ingin laporan bulanan (opsional)"),
            _instructionItem("4. Klik \"Generate PDF\" untuk membuat laporan"),
            _instructionItem("5. PDF akan terbuka di tab baru dan dapat didownload atau dicetak"),
          ],
        ),
      ),
    );
  }

  // HELPER: Label Input
  Widget _buildLabel(String text, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 10),
      child: RichText(
        text: TextSpan(
          text: text,
          style: const TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.w500),
          children: isRequired ? [const TextSpan(text: " *", style: TextStyle(color: Colors.red))] : [],
        ),
      ),
    );
  }

  // HELPER: Dropdown Template
  Widget _buildDropdown({String? hint, String? value, required List<String> items, required Function(String?) onChanged}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: hint != null ? Text(hint, style: const TextStyle(fontSize: 13)) : null,
          value: value,
          items: items.map((String val) {
            return DropdownMenuItem<String>(value: val, child: Text(val, style: const TextStyle(fontSize: 13)));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _instructionItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(text, style: const TextStyle(fontSize: 13, color: Colors.black54)),
    );
  }
}