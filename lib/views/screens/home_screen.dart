import 'package:flutter/material.dart';
import 'package:poseidon_delivery/viewmodel/product_viewmodel.dart';
import '../components/header.dart';
import '../components/banner_carousel.dart';
import '../components/product_catalog.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final products = ProductViewModel().products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const BannerCarousel(),
                  ProductCatalog(products: products),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomHeader(),
          ),
        ],
      ),
    );
  }
}
