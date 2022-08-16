import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants/constant.dart';
import '../../globalTokens.dart';
import '../../main.dart';

class SplashState extends ChangeNotifier {
  SplashState(context) {
    Timer(Duration(seconds: 1),
        () => Navigator.pushNamed(context, '/add_manage'));
    // checkAccessToken();
  }
  final token = GetStorage();
  Dio dio = Dio();
  checkAccessToken() {
    Future.delayed(Duration(seconds: 0), () {
      // var checkToken = savedAccessToken;
      final savedAccessToken = token.read("accessToken");

      if (savedAccessToken == null) {
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
    try {
      final savedAccessToken = token.read("accessToken");
      print(savedAccessToken);

      await dio.get('$url/api/v1/auth/profile',
          options:
              Options(headers: {'Authorization': 'Bearer $savedAccessToken'}));
      print(savedAccessToken);

      // navigatorKey.currentState!
      //     .pushNamedAndRemoveUntil(Home.id, (route) => false);
    } on DioError catch (e) {
      print(e.response);
      isError = true;
      notifyListeners();
    }
  }
}
