import 'package:flutter/material.dart';
import 'package:flutter_application_2/screen/MyCart.dart';
import 'package:flutter_application_2/screen/MyCatalog.dart';
import 'package:flutter_application_2/screen/Checkout.dart';
import 'package:provider/provider.dart';
import 'provider/shoppingcart_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ShoppingCart()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/cart": (context) => const MyCart(),                            // route for MyCart page
        "/products": (context) => const MyCatalog(),                     // route for MyCatalog page
        "/checkout": (context) => const Checkout(),                      // route for Checkout page
      },
      home: const MyCatalog(),
    );
  }
}