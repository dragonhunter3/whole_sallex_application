import 'package:flutter/material.dart';

class CheckoutController extends ChangeNotifier {
  final List<int> _isCheckout = [];

  List<int> get checkoutItems => _isCheckout;

  void toggleCheckout(int index) {
    _isCheckout.add(index);

    notifyListeners();
  }

  void removeCheckout(int index) {
    _isCheckout.remove(index);

    notifyListeners();
  }
}
