import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class PixViewModel extends ChangeNotifier {
  String? _pixCode;
  bool _copied = false;
  bool _paymentSuccess = false;

  String? get pixCode => _pixCode;
  bool get copied => _copied;
  bool get paymentSuccess => _paymentSuccess;

  void generatePixCode() {
    final rand = Random();
    final code = List.generate(32, (_) => rand.nextInt(16).toRadixString(16)).join().toUpperCase();
    _pixCode = '00020126580014BR.GOV.BCB.PIX0114+55999999999952040000530398654041000${code}6304';
    _copied = false;
    _paymentSuccess = false;
    notifyListeners();
  }

  void copyPixCode() {
    _copied = true;
    notifyListeners();

    Timer(const Duration(seconds: 6), () {
      _paymentSuccess = true;
      notifyListeners();
    });
  }

  void reset() {
    _pixCode = null;
    _copied = false;
    _paymentSuccess = false;
    notifyListeners();
  }
}
