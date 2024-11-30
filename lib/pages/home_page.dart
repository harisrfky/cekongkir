import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Raja Ongkir'), // Judul aplikasi
        backgroundColor: Color(0xFFF9B904), // Warna appbar HEX #f9b904
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Aplikasi ini digunakan untuk cek ongkir pada ekspedisi JNE, TIKI, dan POS INDONESIA',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30), // Jarak antara teks dan tombol
            ElevatedButton(
              onPressed: () {
                // Arahkan ke halaman ShippingPage
                Navigator.pushNamed(context, '/shipping');
              },
              child: Text('Cek Ongkir', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF9B904), // Warna HEX #f9b904
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
                height: 20), // Jarak antara tombol dan teks "Supported by:"
            Text(
              'Supported by:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10), // Jarak antara teks "Supported by:" dan logo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/rajaongkir.png', // Logo Raja Ongkir
                  width: 60,
                  height: 60,
                ),
                Image.asset(
                  'assets/jne.png', // Logo JNE
                  width: 60,
                  height: 60,
                ),
                Image.asset(
                  'assets/tiki.png', // Logo TIKI
                  width: 60,
                  height: 60,
                ),
                Image.asset(
                  'assets/pos.png', // Logo POS Indonesia
                  width: 60,
                  height: 60,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
