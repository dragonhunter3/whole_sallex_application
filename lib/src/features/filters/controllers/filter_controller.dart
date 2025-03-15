import 'package:flutter/material.dart';

class FilterController extends ChangeNotifier {
  double _startPrice = 78.0; // Initial min price
  double _endPrice = 143.0; // Initial max price
  final double _minPrice = 78.0;
  final double _maxPrice = 143.0;

  double get startPrice => _startPrice;
  double get endPrice => _endPrice;
  double get minPrice => _minPrice;
  double get maxPrice => _maxPrice;

  void updateRange(double start, double end) {
    _startPrice = start;
    _endPrice = end;
    notifyListeners(); // UI ko update karne ke liye
  }

  int _selectedIndex = -1; // Initially, no item is selected

  int get selectedIndex => _selectedIndex;

  void selectIndex(int index) {
    _selectedIndex = index;
    notifyListeners(); // Notify UI to update
  }

  List<int> selected = []; // Store multiple selected indexes

  List<int> get selecIndex => selected;

  void toggleSelection(int index) {
    if (selected.contains(index)) {
      selecIndex.remove(index); // Deselect if already selected
    } else {
      selecIndex.add(index); // Select new item
    }
    notifyListeners();
  }

  List<int> selectedCategory = [];
  List get selectedCategoryIndex => selectedCategory;
  void toggleCategory(int index) {
    if (selectedCategory.contains(index)) {
      selectedCategoryIndex.remove(index);
    } else {
      selectedCategoryIndex.add(index);
    }
    notifyListeners();
  }

  final Map<String, bool> _selectedBrands = {};

  // Get selected state of a brand
  bool isSelected(String brand) => _selectedBrands[brand] ?? false;

  // Toggle selection of a brand
  void toggleBrand(String brand) {
    _selectedBrands[brand] = !isSelected(brand);
    notifyListeners();
  }
}
