import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/core/services/local_storage_services.dart';
import 'package:the_green_manual/core/services/toast_service.dart';
import 'package:the_green_manual/main.dart';

class CreateScreenState extends ChangeNotifier {
  String? projectName;
  String? productName;
  String? name;
  String? model;

  Dio dio = getHttp();

  onModelChanged(val) {
    model = val;
    notifyListeners();
  }

  onNameChanged(val) {
    name = val;
    notifyListeners();
  }

  onProjectNameChanged(val) {
    projectName = val;
    notifyListeners();
  }

  onProductNameChanged(val) {
    productName = val;
    notifyListeners();
  }

  bool submitLoading = false;
  setSubmitLoading(val) {
    submitLoading = val;
    notifyListeners();
  }

  createProjects() async {
    setSubmitLoading(true);
    var data = {'name': name, 'model': model, 'category': 'Personal'};
    // final token = LocalStorageService().read(LocalStorageKeys.accessToken);
    final token = LocalStorageService().read(LocalStorageKeys.accessToken);

    try {
      var res = await dio.post('/v1/products/personal-product', data: data);
      print(res);
      ToastService().s('Created Successfully');
      // navigatorKey.currentState!
      //     .pushNamedAndRemoveUntil('/inventory_screen', (route) => false);
    } on DioError catch (e) {
      // ToastService().e(e.message[0] ?? "Error");
    }
    setSubmitLoading(false);
  }
}
