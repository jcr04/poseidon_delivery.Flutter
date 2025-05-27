import 'package:flutter/material.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;
  CartItem({required this.product, this.quantity = 1});
}

class CartViewModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  double get subtotal => _items.fold(0, (sum, item) => sum + item.product.price * item.quantity);
  double get shipping => 5.0;
  double get total => subtotal + shipping;

  void addToCart(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index == -1) {
      _items.add(CartItem(product: product));
    } else {
      _items[index].quantity++;
    }
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void changeQuantity(CartItem item, int value) {
    final index = _items.indexOf(item);
    if (index != -1) {
      _items[index].quantity += value;
      if (_items[index].quantity <= 0) {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
