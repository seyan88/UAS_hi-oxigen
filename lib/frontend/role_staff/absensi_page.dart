import 'package:flutter/material.dart';
import '../widgets/custom_sidebar.dart'; // Pastikan import file sidebar Anda di sini

// --- WARNA KONSTANTA SESUAI REQUEST ---
const Color kNavyOxigen = Color(0xFF0D1B3E);
const Color kBlueOxigen = Color(0xFF2E5BFF);
const Color kLightBlueBg = Color(0xFFE3F2FD);

// ==========================================
// SCREEN 1: PILIH PERIODE & PERTEMUAN (Gambar 2)
// ==========================================
class AbsensiPage extends StatelessWidget {
  const AbsensiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Input Absensi"),
        backgroundColor: Colors.white,
        foregroundColor: kNavyOxigen,
        elevation: 1,
      ),
      // Integrasikan Sidebar yang Anda berikan
      drawer: const CustomSidebar(role: 'staff'), 
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pilih Periode & Pertemuan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kNavyOxigen),
            ),
            const SizedBox(height: 20),

            // --- DATABASE INTEGRATION COMMENT ---
            // Di sini Anda akan menggunakan StreamBuilder atau FutureBuilder 
            // mengambil data dari collection 'periode' di Firebase.
            // Contoh: Firestore.instance.collection('periode').where('isActive', isEqualTo: true)...

            // MOCK DATA: Contoh Card Periode "Semester Genap 2025/2026"
            _buildPeriodeCard(
              context,
              title: "Semester Genap 2025/2026",
              dateRange: "28/01/2026 - 20/12/2026",
              meetings: List.generate(14, (index) => index + 1), // 14 Pertemuan
            ),

            const SizedBox(height: 20),

            // MOCK DATA: Contoh Card "Pelatihan BPH"
            _buildPeriodeCard(
              context,
              title: "Pelatihan BPH",
              dateRange: "17/01/2026 - 31/01/2026",
              meetings: [1, 2, 3, 4],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodeCard(BuildContext context, {required String title, required String dateRange, required List<int> meetings}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(dateRange, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            const Divider(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: meetings.map((meetingNum) {
                // Logika status pertemuan (contoh: pertemuan 1 sudah ada data, sisanya belum)
                bool isDone = meetingNum == 1; 
                
                return InkWell(
                  onTap: () {
                    // Navigasi ke halaman detail input absensi
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InputAbsensiPage(
                          periode: title,
                          pertemuan: meetingNum,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 100,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: isDone ? kBlueOxigen : Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                      color: isDone ? kBlueOxigen.withOpacity(0.05) : Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Pertemuan $meetingNum", style: TextStyle(fontWeight: FontWeight.bold, color: kNavyOxigen)),
                        const SizedBox(height: 4),
                        Text(
                          isDone ? "28/01/2026" : "Belum ditentukan",
                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isDone ? "0 mhs absen" : "0 mhs absen", // Ambil count dari DB
                          style: const TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// SCREEN 2: INPUT DATA MAHASISWA (Gambar 1)
// ==========================================
class InputAbsensiPage extends StatefulWidget {
  final String periode;
  final int pertemuan;

  const InputAbsensiPage({super.key, required this.periode, required this.pertemuan});

  @override
  State<InputAbsensiPage> createState() => _InputAbsensiPageState();
}

class _InputAbsensiPageState extends State<InputAbsensiPage> {
  // MOCK DATA MAHASISWA
  // --- DATABASE INTEGRATION COMMENT ---
  // Saat InitState, fetch data mahasiswa yang aktif pada periode ini dari Firebase.
  // collection('mahasiswa').where('status', isEqualTo: 'aktif')...
  List<Map<String, dynamic>> students = [
    {"id": "1", "nim": "2355110315", "nama": "Supriadi", "angkatan": "2025", "status": null},
    {"id": "2", "nim": "2355110319", "nama": "Supriandi", "angkatan": "2025", "status": null},
    {"id": "3", "nim": "2024001", "nama": "Budi Santoso", "angkatan": "2024", "status": null},
    {"id": "4", "nim": "254698625", "nama": "Solehudin", "angkatan": "2024", "status": null},
    {"id": "5", "nim": "2023001", "nama": "Ahmad Rizki", "angkatan": "2023", "status": null},
  ];

  final List<String> statusOptions = ["Hadir", "Izin", "Sakit", "Alpha"];

  // Fungsi Helper: Mengubah semua status sekaligus
  void _setAllStatus(String status) {
    setState(() {
      for (var student in students) {
        student['status'] = status;
      }
    });
  }

  // Fungsi Simpan ke Database
  void _saveAbsensi() {
    // --- DATABASE INTEGRATION COMMENT ---
    // 1. Buat object data absensi.
    // 2. Loop list 'students' dan simpan ke sub-collection 'absensi_detail' atau array di Firestore.
    // Contoh:
    /*
      FirebaseFirestore.instance.collection('absensi').add({
        'periode': widget.periode,
        'pertemuan': widget.pertemuan,
        'tanggal': DateTime.now(),
        'detail': students.map((s) => {
          'nim': s['nim'],
          'nama': s['nama'],
          'status': s['status'] ?? 'Alpha' // Default Alpha jika null
        }).toList(),
      });
    */
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Data Absensi Disimpan (Mock)")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Input Absensi"),
        backgroundColor: Colors.white,
        foregroundColor: kNavyOxigen,
        elevation: 1,
      ),
      body: Column(
        children: [
          // 1. Header Info (Kotak Biru Muda)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFE0F7FA), // Mirip screenshot
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow("Periode:", widget.periode),
                _buildInfoRow("Pertemuan:", "${widget.pertemuan}"),
                _buildInfoRow("Tanggal:", "28/01/2026"), // Bisa pakai DateFormat
              ],
            ),
          ),

          // 2. Judul & Tombol Batch Action
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Daftar Mahasiswa", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _buildBatchButton("Semua Hadir", Colors.green, () => _setAllStatus("Hadir")),
                    const SizedBox(width: 8),
                    _buildBatchButton("Semua Izin", Colors.orange, () => _setAllStatus("Izin")),
                    const SizedBox(width: 8),
                    _buildBatchButton("Semua Alpha", Colors.red, () => _setAllStatus("Alpha")),
                  ],
                )
              ],
            ),
          ),

          // 3. Table List (Menggunakan ListView agar scrollable)
          Expanded(
            child: ListView.separated(
              itemCount: students.length,
              separatorBuilder: (ctx, i) => const Divider(),
              itemBuilder: (context, index) {
                final student = students[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      // Kolom No
                      SizedBox(
                        width: 30, 
                        child: Text("${index + 1}", style: const TextStyle(color: Colors.grey)),
                      ),
                      // Kolom Info Mahasiswa
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(student['nama'], style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text("${student['nim']} • Angkatan ${student['angkatan']}", 
                              style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                          ],
                        ),
                      ),
                      // Kolom Dropdown Status
                      Container(
                        width: 130,
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: student['status'],
                            hint: const Text("-- Pilih --", style: TextStyle(fontSize: 12)),
                            isExpanded: true,
                            items: statusOptions.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: const TextStyle(fontSize: 13)),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                student['status'] = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // 4. Footer Buttons (Simpan / Batal)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: const Offset(0, -2))],
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _saveAbsensi,
                    icon: const Icon(Icons.save, color: Colors.white),
                    label: const Text("Simpan Absensi", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kBlueOxigen,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Batal", style: TextStyle(color: Colors.grey)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget kecil untuk info baris header
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black87, fontSize: 14),
          children: [
            TextSpan(text: "$label ", style: const TextStyle(fontWeight: FontWeight.bold, color: kNavyOxigen)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  // Widget tombol batch (Hadir semua, dll)
  Widget _buildBatchButton(String text, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
      ),
    );
  }
}