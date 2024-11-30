import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Setelah 3 detik, pindah ke HomePage
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang putih
      body: Center(
        child: Image.asset(
          'assets/rajaongkir.png', // Path gambar lokal
          width: 200, // Ukuran gambar
          height: 200, // Ukuran gambar
          fit: BoxFit.contain, // Gambar sesuai ukuran
        ),
      ),
    );
  }
}
