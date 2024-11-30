import 'package:flutter/material.dart';
import 'package:rajaongkir/pages/splash_screen.dart';
import 'package:rajaongkir/pages/home_page.dart';
import 'package:rajaongkir/pages/shipping_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomePage(),
        '/shipping': (context) => ShippingPage(),
      },
    );
  }
}
