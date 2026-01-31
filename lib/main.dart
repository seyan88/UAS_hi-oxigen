import 'package:flutter/material.dart';
// Mengimport file login_page dari folder frontend
import 'frontend/login_page.dart'; 
import 'frontend/role_staff/dashboard_staff.dart';
import 'frontend/role_ketua/dashboard_ketua.dart';
import 'frontend/role_ketua/approval_absensi_page.dart';
import 'frontend/role_ketua/approval_status_page.dart';
import 'frontend/role_ketua/kelola_periode_page.dart';
import 'frontend/role_ketua/kelola_pertemuan_page.dart';

void main() {
  runApp(const OxigenApp());
}

class OxigenApp extends StatelessWidget {
  const OxigenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug di pojok kanan atas
      title: 'Oxigen Humaniora Internal',
      theme: ThemeData(
        // Mengatur tema warna global aplikasi
        primaryColor: const Color(0xFF0D1B3E), 
        useMaterial3: true,
      ),
      
      // Mengatur halaman awal aplikasi
      initialRoute: '/',
      
      // Definisi rute navigasi aplikasi
      routes: {
        // Memanggil LoginPage yang ada di folder frontend
        '/': (context) => const LoginPage(),
       '/dashboard_staff': (context) => const DashboardStaff(),
      '/dashboard_ketua': (context) => const DashboardKetua(),
      '/approval_absensi': (context) => const ApprovalAbsensiPage(),
      '/approval_status': (context) => const ApprovalStatusPage(),
      '/kelola_periode': (context) => const KelolaPeriodePage(),
      
      },
    );
  }
}