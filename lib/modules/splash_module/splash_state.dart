// ignore_for_file: empty_catches, unused_catch_clause

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
    serializeAndNavigate();
  }

  serializeAndNavigate() {
    final isFirstTime =
        LocalStorageService().read(LocalStorageKeys.isFirstTime);
    if (isFirstTime == null) {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          navigatorKey.currentState!.pushNamed('/add_manage');
        },
      );
    } else {
      if (token == null) {
        Future.delayed(
          const Duration(seconds: 2),
          () {
            navigatorKey.currentState!
                .pushNamedAndRemoveUntil('/login', (route) => false);
          },
        );
      } else {
        validAccessToken();
        // navigatorKey.currentState!
        //     .pushNamedAndRemoveUntil('/home', (route) => false);
      }
    }
  }

  bool isError = false;

  validAccessToken() async {
    try {
      var response = await dio.get('/v1/auth/fetch-profile');
      print(response.data['data']['user']['role']);
      if (response.data['data']['user']['role'] == 'client') {
        Future.delayed(
          const Duration(seconds: 2),
          () {
            navigatorKey.currentState!
                .pushNamedAndRemoveUntil('/client_home', (route) => false);
          },
        );
      } else {
        Future.delayed(
          const Duration(seconds: 2),
          () {
            navigatorKey.currentState!
                .pushNamedAndRemoveUntil('/home', (route) => false);
          },
        );
      }
    } on DioError catch (e) {
      LocalStorageService().clear(LocalStorageKeys.accessToken);
      Future.delayed(
        const Duration(seconds: 2),
        () {
          navigatorKey.currentState!
              .pushNamedAndRemoveUntil('/login', (route) => false);
        },
      );
    }
  }
}
