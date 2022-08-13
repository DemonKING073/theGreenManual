import 'package:dio/dio.dart';
import 'package:the_green_manual/core/http/http.dart';

import 'package:the_green_manual/core/services/local_storage_services.dart';
import 'package:the_green_manual/core/states/base_state.dart';

import '../../main.dart';

class SplashState extends BaseState {
  Dio dio = getHttp();

  String? token;
  SplashState() {
    token = LocalStorageService().read(LocalStorageKeys.accessToken);
    if (token == null) {
      navigatorKey.currentState!
          .pushNamedAndRemoveUntil('/register', (route) => false);
    } else {
      validAccessToken();
    }
  }

  bool isError = false;

  validAccessToken() async {
    try {
      await dio.get('/auth/profile');
      navigatorKey.currentState!
          .pushNamedAndRemoveUntil('/home', (route) => false);
    } on DioError catch (e) {
      print(e);
    }
  }
}
