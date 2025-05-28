import 'package:flutter/material.dart';
import 'package:poseidon_delivery/viewmodel/cart_viewmodel.dart';
import 'package:provider/provider.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCount = context.select<CartViewModel, int>(
      (cart) => cart.items.fold(0, (total, item) => total + item.quantity),
    );

    return Container(
      color: Colors.lightBlue,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: Row(
        children: [
          Row(
            children: [
              Image.asset('lib/assets/images/Logo.png', height: 48),
              const SizedBox(width: 12),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              _HeaderButton(
                'Produtos',
                onTap: () {
                  if (ModalRoute.of(context)?.settings.name != '/') {
                    Navigator.pushNamed(context, '/');
                  }
                },
              ),
              _HeaderButton(
                'Carrinho',
                onTap: () {
                  if (ModalRoute.of(context)?.settings.name != '/cart') {
                    Navigator.pushNamed(context, '/cart');
                  }
                },
                count: cartCount,
              ),
              _HeaderButton(
                'Colaboradores',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Página de Colaboradores em breve!')),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final int? count;
  const _HeaderButton(this.text, {required this.onTap, this.count, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = Text(text, style: const TextStyle(color: Colors.white, fontSize: 16));

    if (count != null && count! > 0) {
      child = Stack(
        clipBehavior: Clip.none,
        children: [
          child,
          Positioned(
            right: -12,
            top: -8,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 31, 134, 165),
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(
                minWidth: 20,
                minHeight: 20,
              ),
              child: Text(
                '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
    }

    return TextButton(
      onPressed: onTap,
      child: child,
    );
  }
}

