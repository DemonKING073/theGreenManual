import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:the_green_manual/apiModels/profile.dart';
import 'package:the_green_manual/core/http/http.dart';

class ProfileState extends ChangeNotifier {
  ProfileState() {
    fetchProfile();
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
      print(response);
    } on DioError catch (e) {
      print(e.response);
      print('yo error ho..');
    }
    setLoading(false);
  }
}
