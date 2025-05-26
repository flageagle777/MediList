import 'package:flutter/material.dart';
import 'package:medilist/pages/produk/produk-page.dart';
import 'package:medilist/pages/supplier/supplier-page.dart';
import 'package:medilist/pages/dashboard/dashboard.dart';
import 'package:medilist/pages/auth/login.dart';
import 'package:medilist/pages/auth/signup.dart';
import 'package:medilist/pages/splash-screen/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medilist',
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash',
      routes: {
        'splash': (_) => const Splashscreen(),
        'login': (context) => const Loginpage(),
        'dashboard': (context) => const SalesSummaryPage(),
        'signup': (context) => const SignUpPage(),
        'supplier': (_) => const SupplierPage(),
        'produk': (_) => const ProductPage(),
      },
    );
  }
}
