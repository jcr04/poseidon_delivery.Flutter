import 'dart:async';
import 'package:flutter/material.dart';

enum CardPaymentType { debito, credito }

class DebitoViewModel extends ChangeNotifier {
  // Campos do cartão
  String cardNumber = '';
  String cardHolder = '';
  String cardExpiry = '';
  String cardCVV = '';

  CardPaymentType? paymentType;
  bool isProcessing = false;
  bool isSuccess = false;
  String? errorMsg;

  void selectPaymentType(CardPaymentType type) {
  paymentType = type;
  print('Selecionado: $type');
  notifyListeners();
  }


  void setCardNumber(String value) {
    cardNumber = value;
    notifyListeners();
  }

  void setCardHolder(String value) {
    cardHolder = value;
    notifyListeners();
  }

  void setCardExpiry(String value) {
    cardExpiry = value;
    notifyListeners();
  }

  void setCardCVV(String value) {
    cardCVV = value;
    notifyListeners();
  }

  bool get isCardValid {
    return cardNumber.replaceAll(' ', '').length == 16 &&
        cardHolder.isNotEmpty &&
        cardExpiry.length == 5 && 
        cardCVV.length == 3 &&
        paymentType != null;
  }

  Future<void> processPayment() async {
    if (!isCardValid) {
      errorMsg = "Preencha todos os campos corretamente.";
      notifyListeners();
      return;
    }
    errorMsg = null;
    isProcessing = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 4));
    isProcessing = false;
    isSuccess = true;
    notifyListeners();
  }

  void reset() {
    cardNumber = '';
    cardHolder = '';
    cardExpiry = '';
    cardCVV = '';
    paymentType = null;
    isProcessing = false;
    isSuccess = false;
    errorMsg = null;
    notifyListeners();
  }
}
