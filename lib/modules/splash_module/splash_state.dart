import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:the_green_manual/core/services/local_storage_services.dart';

import '../../main.dart';

class SplashState extends ChangeNotifier {
  SplashState() {}
  Dio dio = Dio();
  checkAccessToken() {
    Future.delayed(const Duration(seconds: 0), () {
      final token = LocalStorageService().read(LocalStorageKeys.accessToken);

      if (token == null) {
        navigatorKey.currentState!
            .pushNamedAndRemoveUntil('/register', (route) => false);
      } else {
        validAccessToken();
      }
    });
    notifyListeners();
  }

  bool isError = false;

  validAccessToken() async {
    // print('object');
    // try {
    //   final savedAccessToken = token.read("accessToken");
    //   // print(savedAccessToken);

    //   await dio.get('$url/api/v1/auth/profile',
    //       options:
    //           Options(headers: {'Authorization': 'Bearer $savedAccessToken'}));
    //   // print(savedAccessToken);

    //   navigatorKey.currentState!
    //       .pushNamedAndRemoveUntil(Home.id, (route) => false);
    // } on DioError catch (e) {
    //   print(e.response);
    //   isError = true;
    //   notifyListeners();
    // }
  }
}
