import 'package:flutter/material.dart';
import 'views/screens/home_screen.dart';

void main() {
  runApp(const PoseidonDeliveryApp());
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
      home: HomeScreen(),
      // Futuramente, adicione rotas aqui:
      // routes: {
      //   '/produtos': (context) => ProdutosScreen(),
      //   '/checkout': (context) => CheckoutScreen(),
      //   // etc...
      // },
    );
  }
}
