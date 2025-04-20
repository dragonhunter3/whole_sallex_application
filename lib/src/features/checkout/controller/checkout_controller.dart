import 'package:flutter/material.dart';
import 'package:whole_selle_x_application/src/features/items_screen/widgets/list_of_items.dart';

class CheckoutController extends ChangeNotifier {
  final List<int> _isCheckout = [];

  List<int> get checkoutItems => _isCheckout;

  void toggleCheckout(int index) {
    if (index < -1 || index >= myItems.length) {
      print(" Invalid index: $index (myItems length: ${myItems.length})");
      return;
    }

    if (!_isCheckout.contains(index)) {
      _isCheckout.add(index);
      notifyListeners();
    }
  }

  void removeCheckout(int index) {
    if (_isCheckout.contains(index)) {
      _isCheckout.remove(index);
      notifyListeners();
    }
  }

  bool isChecked = false;
  bool get iChecked => isChecked;
  void checkValue(bool value) {
    isChecked = value;
    notifyListeners();
  }

  bool anisChecked = false;
  bool get aniChecked => isChecked;
  void ancheckValue(bool value) {
    anisChecked = value;
    notifyListeners();
  }
}
