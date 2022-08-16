import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_green_manual/core/services/toast_service.dart';
import 'package:the_green_manual/core/states/base_state.dart';

class LoginState extends BaseState {
  final formKey = GlobalKey<FormState>();

  String? password;
  String? email;

  onEmailChanged(val) {
    email = val;
    notifyListeners();
  }

  onPasswordChanged(val) {
    password = val;
    notifyListeners();
  }

  bool submitLoading = false;
  setSubmitLoading(val) {
    submitLoading = val;
    notifyListeners();
  }

  submitLogin(context) async {
    final firebaseInstance = FirebaseAuth.instance;

    setSubmitLoading(true);
    if (formKey.currentState!.validate()) {
      try {
        await firebaseInstance.createUserWithEmailAndPassword(
            email: email!, password: password!);
        ToastService().s("Registration Successfull!");
      } on FirebaseAuthException catch (e) {
        ToastService().e(e.message ?? "Error");
      }
    }
    setSubmitLoading(false);
  }
}
