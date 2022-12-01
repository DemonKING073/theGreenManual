// ignore_for_file: empty_catches

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/core/services/toast_service.dart';
import 'package:the_green_manual/main.dart';

class ContactUsState extends ChangeNotifier {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final emailController = TextEditingController();
  Dio dio = getHttp();

  bool submitLoading = false;

  onSubmit() async {
    submitLoading = true;
    notifyListeners();
    var data = {
      "name": nameController.text,
      "email": emailController.text,
      "message": descriptionController.text,
    };
    try {
      final response = await dio.post("v1/contacts", data: data);
      ToastService().e(response.data['message']);
      navigatorKey.currentState!.pop();
    } catch (err) {
      navigatorKey.currentState!.pop();
    }
    submitLoading = false;
    notifyListeners();
  }
}
