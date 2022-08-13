import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:the_green_manual/constants/constant.dart';
import 'package:the_green_manual/core/states/base_state.dart';

class RegisterState extends BaseState {
  String? name;
  String? password;
  String? email;
  Dio dio = Dio();

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

  bool isButtonPressed = false;

  final tokenInstance = GetStorage();

  createAccount(context) async {
    isButtonPressed = true;
    notifyListeners();
    var data = {"name": name, "email": email, "password": password};
    try {
      var response =
          await dio.post('$url/api/v1/auth/register-client', data: data);
      // print(response);
      tokenInstance.write('accessToken', response.data['token']);
      Navigator.pushNamedAndRemoveUntil(
          context, '/terms_condition', (route) => false);
    } on DioError catch (e) {
      // print(e.response);
      // showToast('Some Error Occured');
    }
    isButtonPressed = false;
    notifyListeners();
  }
}
