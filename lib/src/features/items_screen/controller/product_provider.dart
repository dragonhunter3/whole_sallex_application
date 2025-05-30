import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:whole_selle_x_application/src/features/categories/model/model.dart';

class ProController with ChangeNotifier {
  ProductModel? _product;
  ProductModel? get product => _product;

  Future<void> fetchProductById(String productId) async {
    final doc = await FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .get();

    if (doc.exists) {
      _product = ProductModel.fromMap(doc.data()!);
      notifyListeners();
    } else {
      _product = null;
      notifyListeners();
    }
  }
}
