import 'package:flutter/material.dart';
import 'package:poseidon_delivery/viewmodel/cart_viewmodel.dart';
import 'package:poseidon_delivery/views/screens/cart_screen.dart';
import 'package:provider/provider.dart';
import 'views/screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartViewModel()),
      ],
      child: const PoseidonDeliveryApp(),
    ),
  );
}
class PoseidonDeliveryApp extends StatelessWidget {
  const PoseidonDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poseidon Delivery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[100],
        fontFamily: 'Roboto',
      ),
      initialRoute: '/', // Use initialRoute ao invés de home
      routes: {
        '/': (context) => HomeScreen(),
        '/cart': (context) => const CartScreen(),
        // Exemplo: '/colaboradores': (context) => ColaboradoresScreen(),
      },
    );
  }
}