import 'package:flutter/material.dart';
import '../widgets/custom_sidebar.dart';
import 'tambah_mahasiswa_page.dart'; // Import halaman baru

class DataMahasiswaPage extends StatefulWidget {
  const DataMahasiswaPage({super.key});

  @override
  State<DataMahasiswaPage> createState() => _DataMahasiswaPageState();
}

class _DataMahasiswaPageState extends State<DataMahasiswaPage> {
  final Color navyOxigen = const Color(0xFF0D1B3E); //
  final Color blueOxigen = const Color(0xFF2E5BFF); //

  String _selectedAngkatan = "Semua Angkatan";
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("HI-Oxigen", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: navyOxigen,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const CustomSidebar(role: 'staff'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER: Judul & Tombol Tambah
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Data Mahasiswa",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TambahMahasiswaPage()),
                    );
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text("Tambah Mahasiswa"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blueOxigen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            
            _buildFilterCard(),
            const SizedBox(height: 20),
            _buildTableCard(),
          ],
        ),
      ),
    );
  }

  // --- WIDGET 1: FILTER & PENCARIAN ---
  Widget _buildFilterCard() {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Filter & Pencarian", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const Divider(height: 30),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Angkatan", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      _buildDropdown(),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Pencarian (NIM/Nama)", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      _buildSearchField(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blueOxigen, 
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                  ),
                  child: const Text("Filter"),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _selectedAngkatan = "Semua Angkatan";
                      _searchController.clear();
                    });
                  },
                  style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                  child: const Text("Reset"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Helper UI Dropdown & Search (Sama seperti sebelumnya namun dengan styling lebih bersih)
  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: _selectedAngkatan,
          items: ["Semua Angkatan", "2023", "2024", "2025"].map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 13)))).toList(),
          onChanged: (val) => setState(() => _selectedAngkatan = val!),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: "Cari...",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey[300]!)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }

  // --- WIDGET 2: DAFTAR MAHASISWA (TABLE) ---
  Widget _buildTableCard() {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Daftar Mahasiswa", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const Divider(height: 30),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.grey[50]),
                columns: const [
                  DataColumn(label: Text("No")),
                  DataColumn(label: Text("NIM")),
                  DataColumn(label: Text("Nama")),
                  DataColumn(label: Text("Angkatan")),
                  DataColumn(label: Text("Status")),
                  DataColumn(label: Text("Aksi")),
                ],
                rows: [
                  _buildDataRow(1, "2355110315", "supriadi", "2025", "Anggota Aktif", blueOxigen),
                  _buildDataRow(2, "2355110319", "supriandi", "2025", "Calon Anggota", Colors.lightBlue),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildDataRow(int no, String nim, String nama, String angkatan, String status, Color color) {
    return DataRow(cells: [
      DataCell(Text("$no")),
      DataCell(Text(nim)),
      DataCell(Text(nama)),
      DataCell(Text(angkatan)),
      DataCell(Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
        child: Text(status, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
      )),
      DataCell(Row(
        children: [
          IconButton(icon: const Icon(Icons.edit, color: Colors.orange, size: 18), onPressed: () {}),
          IconButton(icon: const Icon(Icons.delete, color: Colors.red, size: 18), onPressed: () {}),
        ],
      )),
    ]);
  }
}