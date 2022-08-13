import 'package:flutter/material.dart';

class BaseState extends ChangeNotifier {
  bool loading = false;
  String error = '';

  bool get isLoading => loading == true;
  bool get hasError => error.isNotEmpty;

  setError(String err) {
    error = err;
    notifyListeners();
  }

  clearError() {
    error = '';
    notifyListeners();
  }

  setLoading(bool val) {
    loading = val;
    notifyListeners();
  }
}
