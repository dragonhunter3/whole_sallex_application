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
}
