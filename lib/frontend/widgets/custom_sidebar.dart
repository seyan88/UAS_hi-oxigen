import 'package:flutter/material.dart';

class CustomSidebar extends StatelessWidget {
  final String role; // 'ketua' atau 'staff'

  const CustomSidebar({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    // Variabel Warna berdasarkan Logo Oxigen
    final Color navyOxigen = const Color(0xFF0D1B3E); 
    final Color blueOxigen = const Color(0xFF2E5BFF);

    return Drawer(
      child: Column(
        children: [
          // HEADER SIDEBAR: Menampilkan profil user
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: navyOxigen),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Color(0xFF0D1B3E), size: 40),
            ),
            // --- INTEGRASI FIREBASE ---
            // Nantinya accountName dan accountEmail bisa diambil dari FirebaseAuth.instance.currentUser
            accountName: Text(
              role == 'ketua' ? "Ketua Divisi" : "Staff Humaniora",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: const Text("internal@oxigen.id"),
          ),

          // MENU UTAMA: Dashboard (Dinamis berdasarkan role)
          _buildMenuItem(
            Icons.dashboard_outlined, 
            "Dashboard", 
            () {
              // Menggunakan pushReplacementNamed agar tidak menumpuk halaman dashboard
              Navigator.pushReplacementNamed(
                context, 
                role == 'ketua' ? '/dashboard_ketua' : '/dashboard_staff'
              );
            },
            blueOxigen,
          ),

          const Divider(thickness: 1, indent: 15, endIndent: 15),

          // MENU KHUSUS STAFF
          if (role == 'staff') ...[
            _buildMenuItem(Icons.school_outlined, "Data Mahasiswa", () {
              Navigator.pushNamed(context, '/data_mahasiswa');
            }, blueOxigen),
            _buildMenuItem(Icons.group_outlined, "Keanggotaan", () {
              Navigator.pushNamed(context, '/keanggotaan');
            }, blueOxigen),
            _buildMenuItem(Icons.assignment_turned_in_outlined, "Absensi", () {
              Navigator.pushNamed(context, '/absensi_staff');
            }, blueOxigen),
          ],

          // MENU KHUSUS KETUA
          if (role == 'ketua') ...[
            _buildMenuItem(Icons.how_to_reg_outlined, "Approval Absensi", () {
              Navigator.pushNamed(context, '/approval_absensi');
            }, blueOxigen),
            _buildMenuItem(Icons.rule_outlined, "Approval Status", () {
              Navigator.pushNamed(context, '/approval_status');
            }, blueOxigen),
            _buildMenuItem(Icons.calendar_month_outlined, "Periode", () {
              Navigator.pushNamed(context, '/kelola_periode');
            }, blueOxigen),
            _buildMenuItem(Icons.summarize_outlined, "Laporan", () {
              Navigator.pushNamed(context, '/laporan');
            }, blueOxigen),
          ],

          const Spacer(), // Mendorong menu logout ke paling bawah
          
          const Divider(),
          // TOMBOL KELUAR
          _buildMenuItem(
            Icons.logout_rounded, 
            "Keluar", 
            () {
              // --- INTEGRASI FIREBASE ---
              // Tambahkan: await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/');
            }, 
            Colors.redAccent,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // HELPER WIDGET: Agar kode menu tidak berulang
  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, Color iconColor) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        title, 
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
      ),
      onTap: onTap,
      visualDensity: const VisualDensity(vertical: -1), // Membuat menu sedikit lebih rapat
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}