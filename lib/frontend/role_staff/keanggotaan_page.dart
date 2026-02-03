import 'package:flutter/material.dart';
import '../widgets/custom_sidebar.dart';
import 'ajukan_perubahan_status_page.dart';

class KeanggotaanPage extends StatelessWidget {
  const KeanggotaanPage({super.key});

  final Color navyOxigen = const Color(0xFF0D1B3E); //
  final Color blueOxigen = const Color(0xFF2E5BFF); //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Status Keanggotaan", style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: navyOxigen,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const CustomSidebar(role: 'staff'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Judul & Tombol Ajukan
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Status Keanggotaan", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AjukanPerubahanStatusPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blueOxigen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                  child: const Text("Ajukan Perubahan Status", style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Card Tabel Daftar Status
            _buildStatusTableCard(),
            const SizedBox(height: 20),

            // Card Keterangan Status
            _buildKeteranganCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTableCard() {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Daftar Status Keanggotaan Mahasiswa", style: TextStyle(fontWeight: FontWeight.bold)),
            const Divider(height: 30),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.grey[50]),
                columns: const [
                  DataColumn(label: Text("No")),
                  DataColumn(label: Text("Nama")),
                  DataColumn(label: Text("Status Saat Ini")),
                  DataColumn(label: Text("Approval")),
                ],
                rows: [
                  _buildDataRow(1, "supriadi", "Anggota Aktif", Colors.green, true),
                  _buildDataRow(2, "supriandi", "Calon Anggota", Colors.blue, true),
                  _buildDataRow(3, "Budi Santoso", "Pasif Tahap 2", Colors.orange, true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildDataRow(int no, String nama, String status, Color color, bool isApproved) {
    return DataRow(cells: [
      DataCell(Text("$no")),
      DataCell(Text(nama)),
      DataCell(Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
        child: Text(status, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
      )),
      DataCell(isApproved 
        ? const Icon(Icons.check_circle, color: Colors.green, size: 20) 
        : const Icon(Icons.access_time_filled, color: Colors.grey, size: 20)
      ),
    ]);
  }

  Widget _buildKeteranganCard() {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Keterangan Status Keanggotaan", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            _buildKetItem("CA", "Calon Anggota", "Untuk angkatan baru yang baru mendaftar", Colors.blue),
            _buildKetItem("AK", "Anggota Aktif", "Anggota yang menjadi BPH", Colors.green),
            _buildKetItem("P1", "Pasif Tahap 1", "Maksimal 6 bulan", Colors.orange),
            _buildKetItem("P2", "Pasif Tahap 2", "Maksimal 3 bulan (setelah P1)", Colors.deepOrange),
            _buildKetItem("CO", "Cut Off", "Status akhir jika tetap pasif", Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildKetItem(String code, String title, String desc, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(radius: 12, backgroundColor: color, child: Text(code, style: const TextStyle(color: Colors.white, fontSize: 10))),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: "$title - ",
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
                children: [TextSpan(text: desc, style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black54))],
              ),
            ),
          ),
        ],
      ),
    );
  }
}