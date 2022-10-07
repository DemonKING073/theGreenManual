import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/core/services/toast_service.dart';
import 'package:the_green_manual/core/states/base_state.dart';
import 'package:the_green_manual/main.dart';
import 'package:the_green_manual/modules/scanner_result_module/model/qr_response.dart';

class ScannerResultState extends BaseState {
  Dio dio = getHttp();

  ScannerResultState(context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    id = args;
    notifyListeners();
    fetchProduct();
  }

  late String id;

  QrResponse? productState;

  fetchProduct() async {
    setLoading(true);
    try {
      final res = await dio.get("v1/products/$id");
      productState = QrResponse.fromJson(res.data);
      notifyListeners();
    } catch (err) {
      print(err);
    }
    setLoading(false);
  }

  String? projectName;
  onProjectNameChange(val) {
    projectName = val;
    notifyListeners();
  }

  createProject() async {
    showLoadingDialog();
    var data = {
      "name": projectName,
      "productId": productState!.data!.product!.sId
    };
    try {
      await dio.post('/v1/projects', data: data);
      hideLoadingDialog();
      navigatorKey.currentState!.pop();
      navigatorKey.currentState!
          .pushNamed('/home', arguments: 'inventory screen');
      ToastService().s('Created successfully');
    } on DioError {}
    hideLoadingDialog();
  }
}
