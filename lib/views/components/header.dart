import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
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
          // Navegação
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
  const _HeaderButton(this.text, {required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 16)),
    );
  }
}
