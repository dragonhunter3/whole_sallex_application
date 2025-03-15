import 'package:flutter/material.dart';

class SettingController with ChangeNotifier {
  final Map<String, bool> _switchStates = {}; // Track each switch separately

  bool isSwitchOn(String key) => _switchStates[key] ?? false;

  void toggleSwitch(String key, bool value) {
    _switchStates[key] = value;
    notifyListeners();
  }
}
