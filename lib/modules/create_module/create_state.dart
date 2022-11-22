// ignore_for_file: unnecessary_overrides, empty_catches

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/core/services/local_storage_services.dart';
import 'package:the_green_manual/core/services/toast_service.dart';
import 'package:the_green_manual/core/states/base_state.dart';

class CreateScreenState extends BaseState {
  CreateScreenState() {
    // getSignedUrl();
  }

  @override
  dispose() {
    super.dispose();
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
      setLoading(true);
      var res = await dio.get(
          'v1/auth/s3-signed-url?filename=file.json&filetype=application/json');

      signedUrl = res.data["data"]["signedURL"]["signedURL"];
      filePath = res.data["data"]["signedURL"]["filepath"];

      print("this is signedUrl $signedUrl this is path $filePath");

      FormData data =
          FormData.fromMap({"file": await MultipartFile.fromFile(file!.path)});

      final uploadResult = await dio.put(signedUrl!, data: data);
      // print("this is upload result ${uploadResult.data}");

      // notifyListeners();
      // print(signedUrl);
      // print(filePath);
    } catch (e) {}
  }

  File? file;

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file = File(result.files.single.path!);
      notifyListeners();
      final arr = file!.path.split("/");
      fileName = arr.last;
      notifyListeners();
    } else {
      // User canceled the picker
      ToastService().w("Cancelled by the user!");
    }
  }

  String? fileName;
}
