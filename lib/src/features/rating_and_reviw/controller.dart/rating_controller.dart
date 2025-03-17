import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RatingProvider extends ChangeNotifier {
  double _rating = 0;

  double get rating => _rating;

  void setRating(double value) {
    _rating = value;
    notifyListeners();
  }

  final List<File> _images = [];

  List<File> get images => _images;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _images.add(File(pickedFile.path));
      notifyListeners();
    }
  }
}
