import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../apiModels/profile.dart';
import '../../../core/http/http.dart';
import '../../../core/services/toast_service.dart';

class AdminState extends ChangeNotifier {
  AdminState() {
    fetchProfile();
  }
  File? galleryImage;
  Future pickImage(ImageSource source) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 50);
      if (image == null) return null;
      final imageTemporary = File(image.path);
      galleryImage = imageTemporary;
      notifyListeners();
      updateFileImage(imageTemporary);
      fetchProfile();
    } on PlatformException catch (e) {
      ToastService().e('Failed to pick image: $e');
    }
  }

  Future updateFileImage(image) async {
    isLoading = true;
    notifyListeners();
    String fileName = image.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        image.path,
        // contentType: MediaType("image", "jpeg"),
      ),
    });
    print(formData);
    // var data = {};
    try {
      var updateResponse =
          await dio.patch('/v1/auth/update-picture', data: formData);
      fetchProfile();
    } on DioError catch (e) {
      print(e.response);
    }
    isLoading = false;
    notifyListeners();
  }

  List language = [
    'English',
    'Hindi',
    'Spanish',
  ];

  String? selectedLanguage;
  onLanguageChanged(val) {
    selectedLanguage = val;
    notifyListeners();
  }

  Dio dio = getHttp();
  Profile? profile;

  bool isLoading = false;

  setLoading(val) {
    isLoading = val;
    notifyListeners();
  }

  fetchProfile() async {
    setLoading(true);
    try {
      var response = await dio.get('/v1/auth/fetch-profile');
      profile = Profile.fromJson(response.data);
    } on DioError catch (e) {}
    setLoading(false);
  }
}
