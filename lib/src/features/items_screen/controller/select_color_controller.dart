import 'package:flutter/material.dart';

class SelectedColorProvider extends ChangeNotifier {
  String _selecteColor = "Black";

  String get selecteColor => _selecteColor;

  void setSelectedColor(String newColor) {
    _selecteColor = newColor;
    notifyListeners();
  }
}
