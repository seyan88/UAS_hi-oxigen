import 'package:flutter/material.dart';
import '../widgets/custom_sidebar.dart';

class DashboardKetua extends StatelessWidget {
  const DashboardKetua({super.key});

  @override
  Widget build(BuildContext context) {
    // Warna Identitas Oxigen
    final Color navyOxigen = const Color(0xFF0D1B3E);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ketua Dashboard", style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: navyOxigen,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      // Memanggil Sidebar dengan role ketua
      drawer: const CustomSidebar(role: 'ketua'), 
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Ringkasan Persetujuan",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text("Pantau data yang memerlukan validasi anda", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 25),
            
            // Grid Rangkuman Data Ketua
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
                _buildMetricCard("Total Mahasiswa", "120", Icons.school, Colors.blue),
                _buildMetricCard("Absensi Pending", "15", Icons.pending_actions, Colors.redAccent),
                _buildMetricCard("Status Pending", "8", Icons.fact_check, Colors.orange),
                _buildMetricCard("Total Periode", "4", Icons.date_range, Colors.teal),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget Kartu Metrik (Khusus Dashboard Ketua)
  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, spreadRadius: 2)
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}