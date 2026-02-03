import 'package:flutter/material.dart';

class TambahMahasiswaPage extends StatefulWidget {
  const TambahMahasiswaPage({super.key});

  @override
  State<TambahMahasiswaPage> createState() => _TambahMahasiswaPageState();
}

class _TambahMahasiswaPageState extends State<TambahMahasiswaPage> {
  final Color navyOxigen = const Color(0xFF0D1B3E);
  final Color blueOxigen = const Color(0xFF2E5BFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("HI-Oxigen", style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: navyOxigen,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            // Header Row: Judul & Tombol Kembali
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Tambah Mahasiswa Baru", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, size: 16),
                  label: const Text("Kembali"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Form Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Form Data Mahasiswa", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const Divider(height: 40),
                    
                    _buildInputField("NIM", "Masukkan NIM", isRequired: true),
                    _buildInputField("Nama Lengkap", "Masukkan Nama Lengkap", isRequired: true),
                    
                    // Dropdown Angkatan
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text("Angkatan *", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    ),
                    _buildFormDropdown(),
                    const SizedBox(height: 20),

                    _buildInputField("Email", "Masukkan Email", isRequired: true),
                    _buildInputField("No. Telepon", "Masukkan No. Telepon", isRequired: true),
                    _buildInputField("No. WhatsApp", "Masukkan No. WhatsApp", isRequired: true),

                    const SizedBox(height: 30),

                    // Action Buttons
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Logic Simpan ke Firebase
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blueOxigen,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          ),
                          child: const Text("Simpan"),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[500],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          ),
                          child: const Text("Batal"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper: Input Field dengan Label Merah (Asterisk)
  Widget _buildInputField(String label, String hint, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
              children: isRequired ? [const TextSpan(text: " *", style: TextStyle(color: Colors.red))] : [],
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey[300]!)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: const Text("Pilih Angkatan", style: TextStyle(fontSize: 13)),
          items: ["2023", "2024", "2025"].map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 13)))).toList(),
          onChanged: (val) {},
        ),
      ),
    );
  }
}