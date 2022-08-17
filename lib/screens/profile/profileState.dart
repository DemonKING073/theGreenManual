import 'package:flutter/material.dart';

class ProfileState extends ChangeNotifier {
  List language = [
    'English',
    'Hindi',
    'Spanish',
  ];

  String? selectedLanguage;
  onLanguageChanged(val) {
    selectedLanguage = val;
    notifyListeners();
  }
}
