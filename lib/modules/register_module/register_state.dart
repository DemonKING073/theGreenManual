import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:the_green_manual/core/services/toast_service.dart';

import 'package:the_green_manual/core/states/base_state.dart';
import 'package:the_green_manual/main.dart';

class RegisterState extends BaseState {
  String? name;
  String? password;
  String? email;

  onNameChanged(val) {
    name = val;
    notifyListeners();
  }

  onPasswordChanged(val) {
    password = val;
    notifyListeners();
  }

  onEmailChanged(val) {
    email = val;
    notifyListeners();
  }

  bool submitLoading = false;
  setSubmitLoading(val) {
    submitLoading = val;
    notifyListeners();
  }

  final tokenInstance = GetStorage();
  final formKey = GlobalKey<FormState>();

  createAccount(context) async {
    final firebaseInstance = FirebaseAuth.instance;

    setSubmitLoading(true);
    if (formKey.currentState!.validate()) {
      try {
        await firebaseInstance.createUserWithEmailAndPassword(
            email: email!, password: password!);
        navigatorKey.currentState!.pushNamed('/home_display');
        ToastService().s("Registration Successfull!");
      } on FirebaseAuthException catch (e) {
        ToastService().e(e.message ?? "Error");
      }
    }
    setSubmitLoading(false);
  }
}
