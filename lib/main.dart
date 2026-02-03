import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart'; // Buka komentar ini jika sudah menambah dependensi firebase_core

// Mengimport file dari folder frontend
import 'frontend/login_page.dart'; 
import 'frontend/role_staff/dashboard_staff.dart';
import 'frontend/role_ketua/dashboard_ketua.dart';
import 'frontend/role_ketua/approval_absensi_page.dart';
import 'frontend/role_ketua/approval_status_page.dart';
import 'frontend/role_ketua/kelola_periode_page.dart';
import 'frontend/role_ketua/laporan_page.dart'; // Import halaman laporan baru
import 'frontend/role_staff/data_mahasiswa_page.dart';
import 'frontend/role_staff/keanggotaan_page.dart';
import 'frontend/role_staff/absensi_page.dart';

void main() async {
  // --- KONEKSI DATABASE FIREBASE ---
  // 1. Pastikan sudah menjalankan 'flutterfire configure' di terminal.
  // 2. Buka komentar baris di bawah ini untuk mengaktifkan Firebase:
  
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  
  runApp(const OxigenApp());
}

class OxigenApp extends StatelessWidget {
  const OxigenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      title: 'Oxigen Humaniora Internal',
      theme: ThemeData(
        // Menggunakan skema warna Navy dari Logo Oxigen
        primaryColor: const Color(0xFF0D1B3E), 
        useMaterial3: true,
        // Global style agar konsisten dengan tampilan web
        scaffoldBackgroundColor: Colors.white,
      ),
      
      // Mengatur halaman awal aplikasi
      initialRoute: '/',
      
      // Definisi rute navigasi aplikasi
      routes: {
        '/': (context) => const LoginPage(),
        '/dashboard_staff': (context) => const DashboardStaff(),
        '/dashboard_ketua': (context) => const DashboardKetua(),
        '/approval_absensi': (context) => const ApprovalAbsensiPage(),
        '/approval_status': (context) => const ApprovalStatusPage(),
        '/kelola_periode': (context) => const KelolaPeriodePage(),
        '/laporan': (context) => const LaporanPage(),
        //staff
        '/data_mahasiswa': (context) => const DataMahasiswaPage(),
        '/keanggotaan': (context) => const KeanggotaanPage(),
        '/absensi_staff': (context) => const AbsensiPage(),
        // Catatan: 'KelolaPertemuanPage' tidak didaftarkan di sini karena 
        // memerlukan pengiriman data (arguments) secara dinamis melalui MaterialPageRoute.
      },
    );
  }
}