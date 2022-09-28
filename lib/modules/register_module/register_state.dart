import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:the_green_manual/core/services/toast_service.dart';

import 'package:the_green_manual/core/states/base_state.dart';
import 'package:the_green_manual/main.dart';

import '../../constants/constant.dart';

class RegisterState extends BaseState {
  String? name;
  String? password;
  String? email;

  bool isPasswordVisible = true;

  onVisibilityChanged() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

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

        navigatorKey.currentState!.pushNamed('/login');
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Email verification link send to your email.Please verify email before loging in', style: LBoldTextStyle()),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    "Cancel",
                    style: kTextStyle().copyWith(color: Colors.grey),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                    child: Text(
                      'Ok',
                      style: kTextStyle().copyWith(color: primaryColor),
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                    }),
              ],
            );
          },
        );
        ToastService().s("Registration Successfull!");
      } on FirebaseAuthException catch (e) {
        ToastService().e(e.message ?? "Error");
      }
    }
    setSubmitLoading(false);
  }
}
