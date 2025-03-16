import 'package:flutter/material.dart';

class SizeProvider extends ChangeNotifier {
  String? _selectedSize;

  String? get selectedSize => _selectedSize;

  void selectSize(String size) {
    _selectedSize = size;
    notifyListeners(); // Notify listeners to update UI
  }
}
