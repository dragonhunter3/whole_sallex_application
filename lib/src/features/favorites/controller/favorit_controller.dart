import 'package:flutter/material.dart';

class FavoritesProvider with ChangeNotifier {
  final List<int> _favoriteItems = [];

  List<int> get favoriteItems => _favoriteItems;

  void toggleFavorite(int index) {
    if (_favoriteItems.contains(index)) {
      _favoriteItems.remove(index);
    } else {
      _favoriteItems.add(index);
    }
    notifyListeners();
  }

  bool isFavorite(int index) {
    return _favoriteItems.contains(index);
  }
}
