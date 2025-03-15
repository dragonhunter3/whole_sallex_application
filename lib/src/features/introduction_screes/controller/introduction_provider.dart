import 'package:flutter/material.dart';

class IntroductionProvider extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  void nextIndex() {
    if (_index < 3) {
      _index++;
      notifyListeners();
    }
  }
}
