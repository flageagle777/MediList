import 'package:flutter/material.dart';
import 'package:medilist/views/add_produk.dart';
import 'package:medilist/views/add_supplier.dart';
import 'package:medilist/views/dashboard.dart';
import 'package:medilist/views/login.dart';
import 'package:medilist/views/signup.dart';
import 'package:medilist/views/splashscreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medilist',
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash',
      routes: {
        'splash': (_) => Splashscreen(), 
        'login': (_) => Loginpage(),
        'dashboard': (_) => SalesSummaryPage(),
        'signup': (_) => SignUpPage(),
        'supplier': (_) => SupplierPage(),
        'produk': (_) => produk(),

        }
    );
  }
}