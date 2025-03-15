import 'package:flutter/material.dart';

class BrandController extends ChangeNotifier {
  final Set<String> _selectedBrands = {};

  bool isSelected(String brand) => _selectedBrands.contains(brand);

  void toggleBrand(String brand) {
    if (isSelected(brand)) {
      _selectedBrands.remove(brand);
    } else {
      _selectedBrands.add(brand);
    }
    notifyListeners();
  }

  List<String> get selectedBrands => _selectedBrands.toList();
}
