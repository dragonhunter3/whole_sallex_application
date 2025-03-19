import 'package:flutter/material.dart';
import 'package:whole_selle_x_application/src/features/items_screen/widgets/list_of_items.dart';

class SelectedItemProvider with ChangeNotifier {
  Items? _selectedItem;

  Items? get selectedItem => _selectedItem;

  void setSelectedItem(Items item) {
    _selectedItem = item;
    notifyListeners();
  }

  String? _selectedColor;

  String? get selectedColor => _selectedColor;

  void setColor(String? color) {
    _selectedColor = color;
    notifyListeners();
  }

  String? _selectedSize;

  String? get selectedSize => _selectedSize;

  void selectSize(String size) {
    _selectedSize = size;

    if (_selectedItem != null) {
      _selectedItem!.selectedSize = size;
    }

    notifyListeners();
  }

  String _selecteColor = "Black";

  String get selecteColor => _selecteColor;

  void setSelectedColor(String newColor) {
    _selecteColor = newColor;
    notifyListeners();
  }
}
