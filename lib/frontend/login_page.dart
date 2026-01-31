import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controller untuk mengambil teks dari inputan user
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  // Status untuk menyembunyikan/menampilkan password
  bool _isPasswordVisible = false;

  // Variabel Warna berdasarkan Logo Oxigen
  final Color navyOxigen = const Color(0xFF0D1B3E); // Warna Biru Tua/Gelap
  final Color blueOxigen = const Color(0xFF2E5BFF); // Warna Biru Terang/Aksen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang bersih putih
      body: SingleChildScrollView(
        // SingleChildScrollView agar tidak error saat keyboard HP muncul
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 100), // Jarak atas

              // SEKSI LOGO & HEADER
              Center(
                child: Column(
                  children: [
                    // Ganti Icon ini dengan Image.asset('assets/logo_oxigen.png') jika file gambar sudah ada
                    Icon(Icons.auto_awesome_mosaic, size: 70, color: blueOxigen),
                    const SizedBox(height: 10),
                    Text(
                      'OXIGEN',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: navyOxigen,
                        letterSpacing: 3,
                      ),
                    ),
                    const Text(
                      'Divisi Humaniora Internal',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              // INPUT EMAIL
              _buildInputLabel("Email Kerja"),
              TextField(
                controller: _emailController,
                decoration: _inputDecoration("contoh@oxigen.id", Icons.email_outlined),
              ),

              const SizedBox(height: 20),

              // INPUT PASSWORD
              _buildInputLabel("Password"),
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible, // Menyembunyikan teks
                decoration: _inputDecoration("Masukkan password", Icons.lock_outline).copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // TOMBOL LOGIN (TEMPAT INTEGRASI API)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    String email = _emailController.text.toLowerCase();
                    String password = _passwordController.text;

                    // VALIDASI SEDERHANA (Hanya untuk simulasi)
                    if (email.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Email dan Password harus diisi!")),
                      );
                      return;
                    }

                    // LOGIKA PERCABANGAN ROLE
                    if (email.contains("ketua")) {
                      // Jika email mengandung 'ketua', arahkan ke dashboard ketua
                      Navigator.pushReplacementNamed(context, '/dashboard_ketua');
                    } else {
                      // Selain itu, arahkan ke dashboard staff
                      Navigator.pushReplacementNamed(context, '/dashboard_staff');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: navyOxigen,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    'MASUK',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              const Text("Developed by IT Oxigen", style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget untuk Label Input agar kode tidak berulang
  Widget _buildInputLabel(String label) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: navyOxigen)),
    );
  }

  // Helper Dekorasi Input (Border, Warna, dll)
  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: blueOxigen),
      contentPadding: const EdgeInsets.symmetric(vertical: 15),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: blueOxigen, width: 2),
      ),
    );
  }
}