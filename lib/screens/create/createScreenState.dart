import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/core/services/local_storage_services.dart';
import 'package:the_green_manual/core/services/toast_service.dart';

import '../../constants/constant.dart';

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

  createProjects() async {
    var data = {
      'name': name,
      'model': model,
    };
    // final token = LocalStorageService().read(LocalStorageKeys.accessToken);
    final token = LocalStorageService().read(LocalStorageKeys.accessToken);

    print('create garni bela ko tokjen ho $token');
    try {
      await dio.post('/v1/products/personal-product', data: data);
      ToastService().s('Created Successfully');
    } on DioError catch (e) {
      print(e);
      print(e.response);
      print(e.message);
      // ToastService().e(e.message[0] ?? "Error");
    }
  }
}
