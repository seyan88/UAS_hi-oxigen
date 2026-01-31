import 'package:flutter/material.dart';

class CustomSidebar extends StatelessWidget {
  final String role; // 'ketua' atau 'staff'

  const CustomSidebar({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final Color navyOxigen = const Color(0xFF0D1B3E);

    return Drawer(
      child: Column(
        children: [
          // Header Sidebar
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: navyOxigen),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Color(0xFF0D1B3E)),
            ),
            accountName: Text(role == 'ketua' ? "Ketua Divisi" : "Staff Humaniora"),
            accountEmail: const Text("internal@oxigen.id"),
          ),

          // Menu yang sama untuk semua role
          _buildMenuItem(Icons.dashboard, "Dashboard", () {}),

          // Kondisi: Jika Staff, tampilkan menu spesifik staff
          if (role == 'staff') ...[
            _buildMenuItem(Icons.school, "Data Mahasiswa", () {}),
            _buildMenuItem(Icons.group, "Keanggotaan", () {}),
            _buildMenuItem(Icons.assignment_turned_in, "Absensi", () {}),
          ],

          // Kondisi: Jika Ketua, tambahkan menu Approval/Laporan (Contoh)
          // Bagian di dalam Column di CustomSidebar
          if (role == 'ketua') ...[
           _buildMenuItem(Icons.how_to_reg, "Approval Absensi", () {
              Navigator.pushNamed(context, '/approval_absensi');
            }),
            _buildMenuItem(Icons.rule, "Approval Status", () {
              Navigator.pushNamed(context, '/approval_status');
            }),
            _buildMenuItem(Icons.calendar_month, "Periode", () {}),
            _buildMenuItem(Icons.summarize, "Laporan", () {}),
          ],

          const Spacer(),
          const Divider(),
          _buildMenuItem(Icons.logout, "Keluar", () {
            Navigator.pushReplacementNamed(context, '/');
          }),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF2E5BFF)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }
}