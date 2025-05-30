import 'package:flutter/foundation.dart';

class CheckoutP extends ChangeNotifier {
  int? _selectedCardIndex;

  int? get selectedCardIndex => _selectedCardIndex;

  void selectCard(int? index) {
    _selectedCardIndex = index;
    notifyListeners();
  }

  bool isCardSelected(int index) {
    return _selectedCardIndex == index;
  }
}
