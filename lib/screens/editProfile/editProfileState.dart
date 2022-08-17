import 'package:flutter/material.dart';

class EditProfileState extends ChangeNotifier {
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

  onPhoneNumberChanged(val) {
    phoneNumber = val;
    notifyListeners();
  }

  onDateOfBirthChanged(val) {
    dateOfBirth = val;
    notifyListeners();
  }
}
