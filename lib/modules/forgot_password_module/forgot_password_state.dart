import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/core/services/toast_service.dart';
import 'package:the_green_manual/core/states/base_state.dart';
import 'package:the_green_manual/main.dart';

class ForgotPasswordState extends BaseState {
  final formKey = GlobalKey<FormState>(debugLabel: "NEW");
  Dio dio = getHttp();

  bool submitLoading = false;

  final emailController = TextEditingController();

  setSubmitLoading(val) {
    submitLoading = val;
    notifyListeners();
  }

  onSubmit(val) async {
    if (formKey.currentState!.validate()) {
      setSubmitLoading(true);
      try {
        var data = {
          "email": emailController.text,
        };
        final response =
            await dio.patch("/v1/auth/forget-password", data: data);
        ToastService().s(response.data['message']);
        navigatorKey.currentState!.pop();
      } catch (err) {}
      setSubmitLoading(false);
    }
  }
}
