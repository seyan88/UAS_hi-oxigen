import 'package:flutter/material.dart';

class ApprovalAbsensiPage extends StatefulWidget {
  const ApprovalAbsensiPage({super.key});

  @override
  State<ApprovalAbsensiPage> createState() => _ApprovalAbsensiPageState();
}

class _ApprovalAbsensiPageState extends State<ApprovalAbsensiPage> {
  final Color navyOxigen = const Color(0xFF0D1B3E);
  final Color blueOxigen = const Color(0xFF2E5BFF);

  // Data dengan field 'isSelected' untuk logika checkbox
  List<Map<String, dynamic>> _absensiList = [
    {
      "nama": "Andi Wijaya",
      "nim": "22010123",
      "periode": "Ganjil 2024",
      "pertemuan": "Pertemuan 5",
      "status": "Hadir",
      "isSelected": false
    },
    {
      "nama": "Siti Aminah",
      "nim": "22010125",
      "periode": "Ganjil 2024",
      "pertemuan": "Pertemuan 5",
      "status": "Izin",
      "isSelected": false
    },
    {
      "nama": "Budi Santoso",
      "nim": "22010129",
      "periode": "Ganjil 2024",
      "pertemuan": "Pertemuan 6",
      "status": "Hadir",
      "isSelected": false
    },
  ];

  bool _isAllSelected = false;

  // FUNGSI: Ceklis Semua
  void _selectAll(bool? val) {
    setState(() {
      _isAllSelected = val ?? false;
      for (var item in _absensiList) {
        item['isSelected'] = _isAllSelected;
      }
    });
  }

  // FUNGSI: Update status "Select All" jika item diubah satu per satu
  void _updateSelectAllStatus() {
    setState(() {
      _isAllSelected = _absensiList.every((item) => item['isSelected'] == true);
    });
  }

  @override
  Widget build(BuildContext context) {
    int selectedCount = _absensiList.where((item) => item['isSelected'] == true).length;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Approval Absensi", style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: navyOxigen,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // HEADER: Master Checkbox & Action Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Checkbox(
                  value: _isAllSelected,
                  onChanged: _selectAll,
                  activeColor: blueOxigen,
                ),
                const Text("Pilih Semua", style: TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                // Tombol aksi hanya aktif jika ada yang dipilih
                _buildActionButton("Approve", Colors.green, Icons.check, selectedCount),
                const SizedBox(width: 8),
                _buildActionButton("Tolak", Colors.red, Icons.close, selectedCount),
              ],
            ),
          ),

          // LIST DATA (Menggunakan Desain Card yang Detail)
          Expanded(
            child: _absensiList.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    itemCount: _absensiList.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      return _buildAbsensiCard(_absensiList[index], index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // WIDGET: Tombol Aksi Dinamis
  Widget _buildActionButton(String label, Color color, IconData icon, int count) {
    return Opacity(
      opacity: count > 0 ? 1.0 : 0.5,
      child: GestureDetector(
        onTap: count > 0 ? () {
          // Tambahkan logika API di sini
          print("$label $count data");
        } : null,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 16),
              const SizedBox(width: 4),
              Text(
                count > 0 ? "$label ($count)" : label,
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // WIDGET: Card Detail Mahasiswa
  Widget _buildAbsensiCard(Map<String, dynamic> data, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: data['isSelected'],
              activeColor: blueOxigen,
              onChanged: (val) {
                setState(() => _absensiList[index]['isSelected'] = val);
                _updateSelectAllStatus();
              },
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['nama']!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: navyOxigen),
                  ),
                  Text(
                    "NIM: ${data['nim']}",
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Divider(height: 1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _infoText("Periode", data['periode']!),
                      _infoText("Pertemuan", data['pertemuan']!),
                      _infoText("Status", data['status']!),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // WIDGET: Helper teks informasi kecil
  Widget _infoText(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // WIDGET: Tampilan jika data kosong
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 70, color: Colors.grey[300]),
          const SizedBox(height: 10),
          const Text(
            "Tidak ada absensi yang menunggu approval",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}