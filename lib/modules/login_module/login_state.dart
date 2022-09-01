import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/core/services/local_storage_services.dart';
import 'package:the_green_manual/core/services/toast_service.dart';
import 'package:the_green_manual/core/states/base_state.dart';
import 'package:the_green_manual/main.dart';

class LoginState extends BaseState {
  final formKey = GlobalKey<FormState>();
  Dio dio = getHttp();

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

  bool isPasswordVisible = true;

  onVisibilityChanged() {
    isPasswordVisible = !isPasswordVisible;
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
        final res = await firebaseInstance.signInWithEmailAndPassword(
            email: email!, password: password!);
        final token = await res.user!.getIdToken();
        print(token);
        LocalStorageService().write(LocalStorageKeys.accessToken, token);
        ToastService().s("Login Successfull!");
        getVerification();
      } on FirebaseAuthException catch (e) {
        ToastService().e(e.message ?? "Error");
      }
    }
    setSubmitLoading(false);
  }

  getVerification() async {
    try {
      final token = LocalStorageService().read(LocalStorageKeys.accessToken);
      print("yo token ho $token");
      Dio newDio = Dio();
      final response = await newDio
          .post("https://api-gmanual.herokuapp.com/api/v1/auth/provider-login",
              options: Options(headers: {
                "Firebase-Token": token,
              }),
              data: {
            "provider": "password",
          });
      LocalStorageService()
          .write(LocalStorageKeys.accessToken, response.data['token']);
      navigatorKey.currentState!
          .pushNamedAndRemoveUntil("/home", (route) => false);
      // ignore: empty_catches
    } on DioError {}
  }
}
