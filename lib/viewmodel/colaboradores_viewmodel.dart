import 'package:flutter/material.dart';

class PedidoFinalizado {
  final List<String> produtos;
  final double total;
  final String endereco;
  final String transportadora;
  final DateTime data;

  PedidoFinalizado({
    required this.produtos,
    required this.total,
    required this.endereco,
    required this.transportadora,
    required this.data,
  });
}

// lib/viewmodel/colaboradores_viewmodel.dart
class ColaboradoresViewModel extends ChangeNotifier {
  final List<PedidoFinalizado> _pedidos = [];

  List<PedidoFinalizado> get pedidos => List.unmodifiable(_pedidos);

  int get pedidosCount => _pedidos.length;

  void adicionarPedido(PedidoFinalizado pedido) {
    _pedidos.add(pedido);
    notifyListeners();
  }

  PedidoFinalizado? get pedidoPendente {
    if (_pedidos.isEmpty) return null;
    final last = _pedidos.last;
    if (last.endereco.isEmpty || last.transportadora.isEmpty) {
      return last;
    }
    return null;
  }

  void completarUltimoPedido({required String endereco, required String transportadora}) {
    if (_pedidos.isEmpty) return;
    final last = _pedidos.removeLast();
    final atualizado = PedidoFinalizado(
      produtos: last.produtos,
      total: last.total,
      endereco: endereco,
      transportadora: transportadora,
      data: last.data,
    );
    _pedidos.add(atualizado);
    notifyListeners();
  }
}

