import 'package:flutter/material.dart';

class ContactUsState extends ChangeNotifier {
  String? name;
  String? email;
  String? description;

  onNameChanged(val) {
    name = val;
    notifyListeners();
  }

  onEmailChanged(val) {
    email = val;
    notifyListeners();
  }

  onDescriptionChanged(val) {
    description = val;
    notifyListeners();
  }
}
