library globals;

import 'package:get_storage/get_storage.dart';

final token = GetStorage();
final registrationToken = GetStorage();

final savedAccessToken = token.read('accessToken');

clearToken() {
  token.remove('accessToken');
}
