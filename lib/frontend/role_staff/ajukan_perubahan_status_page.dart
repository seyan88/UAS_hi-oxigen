import 'package:flutter/material.dart';

class AjukanPerubahanStatusPage extends StatefulWidget {
  const AjukanPerubahanStatusPage({super.key});

  @override
  State<AjukanPerubahanStatusPage> createState() => _AjukanPerubahanStatusPageState();
}

class _AjukanPerubahanStatusPageState extends State<AjukanPerubahanStatusPage> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Ajukan Perubahan Status", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, size: 16),
                  label: const Text("Kembali"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[400], foregroundColor: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Form Pengajuan", style: TextStyle(fontWeight: FontWeight.bold)),
                    const Divider(height: 30),

                    _buildLabel("Pilih Mahasiswa", isRequired: true),
                    _buildDropdown("-- Pilih Mahasiswa --"),

                    const SizedBox(height: 20),

                    _buildLabel("Status Baru", isRequired: true),
                    _buildDropdown("-- Pilih Status --"),

                    const SizedBox(height: 20),

                    // Catatan Box Kuning
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.yellow[50],
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.yellow[200]!),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Catatan: Perubahan status memerlukan approval dari Ketua Divisi.",
                              style: TextStyle(fontSize: 12, color: Colors.orange[900], fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(backgroundColor: blueOxigen, foregroundColor: Colors.white),
                          child: const Text("Ajukan Perubahan"),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[400], foregroundColor: Colors.white),
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

  Widget _buildLabel(String text, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          text: text,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
          children: isRequired ? [const TextSpan(text: " *", style: TextStyle(color: Colors.red))] : [],
        ),
      ),
    );
  }

  Widget _buildDropdown(String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(hint, style: const TextStyle(fontSize: 13)),
          items: const [], // Isi dengan data dari Firebase
          onChanged: (val) {},
        ),
      ),
    );
  }
}