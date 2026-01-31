import 'package:flutter/material.dart';
import '../widgets/custom_sidebar.dart';

class DashboardStaff extends StatelessWidget {
  const DashboardStaff({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Staff Dashboard", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0D1B3E),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const CustomSidebar(role: 'staff'), // Panggil Sidebar dengan role staff
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Ringkasan Data",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Grid untuk Rangkuman Data
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // 2 Kolom
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  _buildSummaryCard("Total Mahasiswa", "120", Icons.people, Colors.blue),
                  _buildSummaryCard("Calon Anggota", "45", Icons.person_add, Colors.orange),
                  _buildSummaryCard("Anggota Aktif", "75", Icons.check_circle, Colors.green),
                  _buildSummaryCard("Absensi Pending", "12", Icons.pending_actions, Colors.red),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Helper untuk membuat kartu ringkasan
  Widget _buildSummaryCard(String title, String count, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(count, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}