import 'package:flutter/material.dart';

class CreateScreenState extends ChangeNotifier {
  String? projectName;
  String? productName;

  onProjectNameChanged(val) {
    projectName = val;
    notifyListeners();
  }

  onProductNameChanged(val) {
    productName = val;
    notifyListeners();
  }
}
