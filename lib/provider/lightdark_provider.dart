import 'package:flutter/material.dart';

class LightDarkProvider with ChangeNotifier {
  bool _enableDarkMode = false;

  bool get enableDarkMode => _enableDarkMode;

  set setBrightness(bool value) {
    _enableDarkMode = value;
    notifyListeners(); // Notify listeners to rebuild the UI
  }
}
