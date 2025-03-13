import 'package:flutter/material.dart';

class SortProvider extends ChangeNotifier {
  String _selectedSort = "Popular"; // Default selection

  String get selectedSort => _selectedSort;

  void setSortOption(String newSort) {
    _selectedSort = newSort;
    notifyListeners(); // Notify UI to rebuild
  }
}
