import 'package:flutter/material.dart';
import '../../viewmodel/product_viewmodel.dart';
import '../components/header.dart';
import '../components/banner_carousel.dart';
import '../components/product_catalog.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final products = ProductViewModel().products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomHeader(),
            const BannerCarousel(),
            ProductCatalog(products: products),
          ],
        ),
      ),
    );
  }
}
