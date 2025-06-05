import 'package:flutter/material.dart';
import 'package:poseidon_delivery/viewmodel/cart_viewmodel.dart';
import 'package:provider/provider.dart';
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
                  Image.network(
                    product.imageUrl,
                    height: 100,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Text('R\$${product.price.toStringAsFixed(2)}'),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<CartViewModel>(context, listen: false).addToCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${product.name} adicionado ao carrinho!')),
                      );
                    },
                    child: const Text('Adicionar ao Carrinho'),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
