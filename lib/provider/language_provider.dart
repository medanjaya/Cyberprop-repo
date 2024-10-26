import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  Locale _locale = const Locale('en'); // Default locale

  Locale get locale => _locale;

  void changeLanguage(String langCode) {
    if (langCode == 'en') {
      _locale = const Locale('en');
    } else {
      _locale = const Locale('id');
    }
    notifyListeners(); // Notifikasi kepada pendengar untuk memperbarui UI
  }
}
