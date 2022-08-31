import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:the_green_manual/apiModels/profile.dart';
import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/themes/app_theme.dart';

class ProfileState extends ChangeNotifier {
  ProfileState() {
    fetchProfile();
  }
  List language = [
    'English',
    'Hindi',
    'Spanish',
  ];

  File? galleryImage;
  Future pickImage(ImageSource source) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 50);
      if (image == null) return null;
      final imageTemporary = File(image.path);
      galleryImage = imageTemporary;

      notifyListeners();
      // cropImage();
      updateFileImage(galleryImage!);
      fetchProfile();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future updateFileImage(File file) async {
    isLoading = true;
    notifyListeners();
    String fileName = file.path.split('/').last;
    // FormData formData = FormData.fromMap({
    //   "file": await MultipartFile.fromFile(
    //     file.path,
    //     filename: fileName,
    //     contentType: MediaType("image", "jpeg"),
    //   ),
    // });
    var data = {};
    try {
      var updateResponse = await dio
          .patch('/v1/inventory/products/dynoeats/image', data: data);
      fetchProfile();
    } on DioError catch (e) {
      print(e.message);

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
      print(response);
    } on DioError catch (e) {
      print(e.response);
      print('yo error ho..');
    }
    setLoading(false);
  }
}


//  /api/v1/auth/update-picture
