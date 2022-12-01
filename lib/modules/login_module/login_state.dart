import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:load/load.dart';
import 'package:the_green_manual/constants/constant.dart';
import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/core/services/local_storage_services.dart';
import 'package:the_green_manual/core/services/toast_service.dart';
import 'package:the_green_manual/core/states/base_state.dart';
import 'package:the_green_manual/main.dart';

class LoginState extends BaseState {
  final formKey = GlobalKey<FormState>(debugLabel: "LGN");
  Dio dio = getHttp();

  Future googleLogIn(context) async {
    showLoadingDialog();
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
      LocalStorageService().write(LocalStorageKeys.accessToken, token);
      getVerificationGoogle(context);
    } on FirebaseAuthException catch (err) {
      ToastService().e(err.message ?? "No response from server");
    }
    hideLoadingDialog();
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

  getVerificationGoogle(context) async {
    try {
      final token = LocalStorageService().read(LocalStorageKeys.accessToken);
      Dio newDio = Dio();
      final response = await newDio
          .post("https://api-gmanual.herokuapp.com/api/v1/auth/provider-login",
              options: Options(headers: {
                "Firebase-Token": token,
              }),
              data: {
            "provider": "google",
          });
      // print(
      //     '-------------------------------------------------------------------');
      // print('yo token ho fghgfh:    $token');
      // print(response.data['data']['role']);
      if (response.data['data']['role'] == 'customer') {
        LocalStorageService()
            .write(LocalStorageKeys.accessToken, response.data['token']);
        ToastService().s("Login Successfull!");
        navigatorKey.currentState!
            .pushNamedAndRemoveUntil("/home", (route) => false);
        setSubmitLoading(false);
      } else if (response.data['data']['role'] == 'client') {
        LocalStorageService()
            .write(LocalStorageKeys.accessToken, response.data['token']);
        ToastService().s("Login Successfull!");
        navigatorKey.currentState!
            .pushNamedAndRemoveUntil("/client_home", (route) => false);
        setSubmitLoading(false);
      } else if (response.data['data']['role'] == 'subclient') {
        LocalStorageService()
            .write(LocalStorageKeys.accessToken, response.data['token']);
        ToastService().s("Login Successfull!");
        navigatorKey.currentState!
            .pushNamedAndRemoveUntil("/client_home", (route) => false);
        setSubmitLoading(false);
      }

      // ignore: empty_catches
    } on DioError catch (err) {
      print(err);
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
      print(response);
      print('condo jasto token: $token');
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
                      Navigator.pop(context);
                    }),
              ],
            );
          },
        );
      } else if (response.data['data']['role'] == 'customer') {
        LocalStorageService()
            .write(LocalStorageKeys.accessToken, response.data['token']);
        ToastService().s("Login Successfull!");
        navigatorKey.currentState!
            .pushNamedAndRemoveUntil("/home", (route) => false);
        setSubmitLoading(false);
      } else if (response.data['data']['role'] == 'client') {
        LocalStorageService()
            .write(LocalStorageKeys.accessToken, response.data['token']);
        ToastService().s("Login Successfull!");
        navigatorKey.currentState!
            .pushNamedAndRemoveUntil("/client_home", (route) => false);
        setSubmitLoading(false);
      } else if (response.data['data']['role'] == 'subclient') {
        LocalStorageService()
            .write(LocalStorageKeys.accessToken, response.data['token']);
        ToastService().s("Login Successfull!");
        navigatorKey.currentState!
            .pushNamedAndRemoveUntil("/client_home", (route) => false);
        setSubmitLoading(false);
      }

      // ignore: empty_catches
    } on DioError catch (err) {
      print(err);
    }
  }
}
