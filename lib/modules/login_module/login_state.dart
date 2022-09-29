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
import 'package:the_green_manual/modules/splash_module/splash_screen.dart';

class LoginState extends BaseState {
  final formKey = GlobalKey<FormState>();
  Dio dio = getHttp();

  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogIn() async {
    showLoadingDialog();
    print('ma ya try vitra xu');
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    await FirebaseAuth.instance.signInWithCredential(credential);
    LocalStorageService()
        .write(LocalStorageKeys.accessToken, googleAuth.accessToken);
    notifyListeners();
    ToastService().s("Login Successfull!");
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil("/home", (route) => false);
    print('access token ho yo ${googleAuth.accessToken}');

    print(' yo credentials ho $credential');
    hideLoadingDialog();
    // try {

    // } on DioError catch (e) {
    //   print(e.response);
    // }
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
        print(token);
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
      if (response.data['message'] ==
          'Email verification link sent to your email. Verify your email before login') {
        print('ya aayo');
        // AlertDialog(
        //   title: Text(response.data['message']),
        // );

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
        print(LocalStorageKeys.accessToken);
        ToastService().s("Login Successfull!");
        navigatorKey.currentState!
            .pushNamedAndRemoveUntil("/home", (route) => false);
        setSubmitLoading(false);
      }

      // ignore: empty_catches
    } on DioError {}
  }
}
