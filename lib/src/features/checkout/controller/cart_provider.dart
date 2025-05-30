import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whole_selle_x_application/src/features/categories/model/model.dart';

class CartProvider with ChangeNotifier {
  Stream<List<Map<String, dynamic>>> getCartItems() {
    return FirebaseFirestore.instance
        .collection('cardProduct')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return {
                'product': ProductModel.fromMap({
                  ...data,
                  'id': doc.id,
                }),
                'quantity': data['quantity'] as int? ?? 1,
                'selectedSize': data['selectedSize'] as String?,
                'selectedColor': data['selectedColor'] as String?,
              };
            }).toList());
  }

  Future<void> addToCart(ProductModel product,
      {String? selectedSize, String? selectedColor}) async {
    try {
      await FirebaseFirestore.instance
          .collection('cardProduct')
          .doc(product.id)
          .set({
        ...product.toMap(),
        'quantity': 1,
        'selectedSize': selectedSize,
        'selectedColor': selectedColor,
        'addedAt': FieldValue.serverTimestamp(),
      });
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  Future<void> updateQuantity(String productId, int newQuantity) async {
    if (newQuantity < 1) return;

    try {
      await FirebaseFirestore.instance
          .collection('cardProduct')
          .doc(productId)
          .update({'quantity': newQuantity});
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to update quantity: $e');
    }
  }

  Future<void> removeFromCart(String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection('cardProduct')
          .doc(productId)
          .delete();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to remove from cart: $e');
    }
  }
}
