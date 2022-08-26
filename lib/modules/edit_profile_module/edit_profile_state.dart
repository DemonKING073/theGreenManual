import 'package:dio/dio.dart';
import 'package:the_green_manual/core/services/toast_service.dart';
import 'package:the_green_manual/core/states/base_state.dart';

import '../../apiModels/profile.dart';
import '../../core/http/http.dart';

class EditProfileState extends BaseState {
  EditProfileState() {
    fetchProfile();
  }
  List gender = ['Male', 'Female', 'Others'];
  String? selectedGender;
  onGenderChanged(val) {
    selectedGender = val;
    notifyListeners();
  }

  String? fullName;
  String? address1;
  String? address2;
  String? phoneNumber;
  String? dateOfBirth;

  onFullNameChanged(val) {
    fullName = val;
    notifyListeners();
  }

  onAddress1Changed(val) {
    address1 = val;
    notifyListeners();
  }

  onAddress2Changed(val) {
    address2 = val;
    notifyListeners();
  }

  onDateOfBirthChanged(val) {
    dateOfBirth = val;
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

  bool isPressed = false;

  bool submitLoading = false;
  setSubmitLoading(val) {
    submitLoading = val;
    notifyListeners();
  }

  editProfile() async {
    setSubmitLoading(true);
    var data = {
      "name": fullName,
      "designation": "Developer",
      "language": "Eng",
    };
    print(data);

    try {
      var response = await dio.patch('/v1/auth/update-profile', data: data);
      ToastService().s('Successfully Edited');
      fetchProfile();
    } on DioError catch (e) {
      print('Bigriyo');
      print(e.response);
    }
    setSubmitLoading(false);
  }
}
