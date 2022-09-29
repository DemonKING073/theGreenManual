import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_green_manual/constants/constant.dart';
import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/core/services/local_storage_services.dart';
import 'package:the_green_manual/core/services/toast_service.dart';
import 'package:the_green_manual/core/states/base_state.dart';
import 'package:the_green_manual/main.dart';

class LoginState extends BaseState {
  final formKey = GlobalKey<FormState>();
  Dio dio = getHttp();

  Future googleLogIn(context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final res = await FirebaseAuth.instance.signInWithCredential(credential);

      final token = await res.user!.getIdToken();
      print("yo condo ho $token");
      LocalStorageService().write(LocalStorageKeys.accessToken, token);
      getVerification(context);
    } on FirebaseAuthException catch (err) {
      print(err);
      ToastService().e(err.message ?? "No response from server");
    }
  }

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
        LocalStorageService().write(LocalStorageKeys.accessToken, token);
        getVerification(context);
      } on FirebaseAuthException catch (e) {
        ToastService().e(e.message ?? "Error");
        setSubmitLoading(false);
      }
    } else {
      setSubmitLoading(false);
    }
  }

  getVerification(context) async {
    try {
      final token = LocalStorageService().read(LocalStorageKeys.accessToken);
      Dio newDio = Dio();
      final response = await newDio
          .post("https://api-gmanual.herokuapp.com/api/v1/auth/provider-login",
              options: Options(headers: {
                "Firebase-Token": token,
              }),
              data: {
            "provider": "password",
          });
      if (response.data['message'] ==
          'Email verification link sent to your email. Verify your email before login') {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(response.data['message'], style: LBoldTextStyle()),
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
                      // await overViewState.updateName();
                      Navigator.pop(context);
                      // await overViewState.fetchData();
                    }),
              ],
            );
          },
        );
      } else {
        LocalStorageService()
            .write(LocalStorageKeys.accessToken, response.data['token']);
        ToastService().s("Login Successfull!");
        navigatorKey.currentState!
            .pushNamedAndRemoveUntil("/home", (route) => false);
        setSubmitLoading(false);
      }

      // ignore: empty_catches
    } on DioError catch (err) {}
  }
}
