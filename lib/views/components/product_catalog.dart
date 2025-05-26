import 'package:flutter/material.dart';
import '../../models/product.dart';

class ProductCatalog extends StatelessWidget {
  final List<Product> products;
  const ProductCatalog({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Produtos Disponíveis',
            style: TextStyle(fontSize: 32, color: Colors.blue),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 0.65,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              child: Column(
                children: [
                  Image.asset(product.imageUrl, height: 100),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Text('R\$${product.price.toStringAsFixed(2)}'),
                  TextButton(onPressed: () {/* ver detalhes */}, child: const Text('Ver detalhes')),
                  ElevatedButton(onPressed: () {/* add carrinho */}, child: const Text('Adicionar ao Carrinho')),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
