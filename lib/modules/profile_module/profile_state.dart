// ignore_for_file: unnecessary_overrides

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_green_manual/apiModels/profile.dart';
import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/core/services/toast_service.dart';

class ProfileState extends ChangeNotifier {
  ProfileState() {
    fetchProfile();
  }
  List language = [
    'English',
    'Hindi',
    'Spanish',
  ];
  @override
  void dispose() {
    super.dispose();
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
      // fetchProfile();
    } on PlatformException catch (e) {
      ToastService().e('Failed to pick image: $e');
    }
  }

  Future updateFileImage(image) async {
    isLoading = true;
    notifyListeners();
    String fileName = image.path.split('/').last;
    // FormData formData = FormData.fromMap({
    //   "image": await MultipartFile.fromFile(
    //     image.path,
    //     // contentType: MediaType("image", "jpeg"),
    //   ),
    // });
    FormData data =
        FormData.fromMap({"image": await MultipartFile.fromFile(image!.path)});
    print(data);
    // var data = {};
    try {
      var updateResponse =
          await dio.patch('/v1/auth/update-picture', data: data);
      fetchProfile();
    } on DioError catch (e) {
      print(e.response);
    }
    isLoading = false;
    notifyListeners();
  }

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


//  /api/v1/auth/update-picture
