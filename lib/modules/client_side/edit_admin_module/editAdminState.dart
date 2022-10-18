import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:the_green_manual/core/states/base_state.dart';

import '../../../apiModels/profile.dart';
import '../../../core/http/http.dart';
import '../../../core/services/toast_service.dart';

class EditAdminState extends BaseState{
  List gender = ['Male', 'Female', 'Others'];
  String? selectedGender;
  onGenderChanged(val) {
    selectedGender = val;
    notifyListeners();
  }

  bool isEditable = false;
  final nameController = TextEditingController();
  final add1Controller = TextEditingController();
  final add2Controller = TextEditingController();

  Dio dio = getHttp();
  Profile? profile;

  fetchProfile() async {
    setLoading(true);
    try {
      var response = await dio.get('/v1/auth/fetch-profile');
      profile = Profile.fromJson(response.data);
      notifyListeners();
      nameController.text = profile!.data!.user!.name ?? "";
      add1Controller.text = profile!.data!.user!.addresses?.address1 ?? "";
      add2Controller.text = profile!.data!.user!.addresses?.address2 ?? "";
      switch (profile!.data!.user!.gender) {
        case "M":
          selectedGender = "Male";
          notifyListeners();
          break;
        case "F":
          selectedGender = "Female";
          notifyListeners();
          break;
        case "O":
          selectedGender = "Others";
          notifyListeners();
          break;
      }
    } on DioError catch (e) {}
    setLoading(false);
  }

  bool isPressed = false;

  bool submitLoading = false;
  setSubmitLoading(val) {
    submitLoading = val;
    notifyListeners();
  }

  editProfile() async {
    setSubmitLoading(true);
    var data = {
      "name": nameController.text,
      "language": "Eng",
      "addresses.address1": add1Controller.text,
      "addresses.address2": add2Controller.text,
      "gender": selectedGender![0],
    };
    try {
      var response = await dio.patch('/v1/auth/update-profile', data: data);
      ToastService().s('Successfully Edited');
      fetchProfile();
    } on DioError catch (e) {}
    setSubmitLoading(false);
  }
}