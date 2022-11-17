import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/core/services/local_storage_services.dart';
import 'package:the_green_manual/core/services/toast_service.dart';
import 'package:the_green_manual/main.dart';

class CreateScreenState extends ChangeNotifier {
  CreateScreenState() {
    getSignedUrl();
  }
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

  String? signedUrl;
  String? filePath;

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
      print(e.response);
    }
    setSubmitLoading(false);
  }

  getSignedUrl() async {
    try {
      var res = await dio.get(
          '/v1/auth/s3-signed-url?filename=file.json&filetype=application/json');
      print(res);
      signedUrl = res.data["data"]["signedURL"]["signedURL"];
      filePath = res.data["data"]["signedURL"]["filepath"];
      notifyListeners();
      print(signedUrl);
      print(filePath);

      // ToastService().s('Created Successfully');
      // navigatorKey.currentState!
      //     .pushNamedAndRemoveUntil('/inventory_screen', (route) => false);
    } on DioError catch (e) {
      // ToastService().e(e.message[0] ?? "Error");
    }
  }

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      createFromSignedUrl(file);
    } else {
      // User canceled the picker
    }
  }

  createFromSignedUrl(path) async {
    FormData data =
        FormData.fromMap({"image": await MultipartFile.fromFile(path!.path)});
    print(data.files);
    try {
      var res = await dio.put(signedUrl!, data: data);
    } catch (e) {}
  }
}
