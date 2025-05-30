import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> _favoriteIds = [];

  FavoritesProvider() {
    _loadFavorites();
  }
  List<String> get favoriteIds => _favoriteIds;
  bool isFavorite(String productId) {
    return _favoriteIds.contains(productId);
  }

  Future<void> _loadFavorites() async {
    try {
      final snapshot = await _firestore.collection('favorites').get();
      _favoriteIds.clear();
      _favoriteIds.addAll(snapshot.docs.map((doc) => doc.id));
      notifyListeners();
    } catch (e) {
      print('Error loading favorites: $e');
    }
  }

  Future<void> toggleFavorite(String productId) async {
    try {
      final docRef = _firestore.collection('favorites').doc(productId);
      final doc = await docRef.get();

      if (doc.exists) {
        await docRef.delete();
        _favoriteIds.remove(productId);
      } else {
        await docRef.set({
          'productId': productId,
          'addedAt': FieldValue.serverTimestamp(),
        });
        _favoriteIds.add(productId);
      }
      notifyListeners();
    } catch (e) {
      print('Error toggling favorite: $e');
      throw Exception('Failed to toggle favorite: $e');
    }
  }
}
