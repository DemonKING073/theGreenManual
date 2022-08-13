import 'package:the_green_manual/core/services/local_storage_services.dart';
import 'package:the_green_manual/core/states/base_state.dart';
import 'package:the_green_manual/main.dart';

class PrivateAndSecureState extends BaseState {
  getStarted() {
    // LocalStorageService().write(LocalStorageKeys.isFirstTime, 'yes');
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil('/welcome', (route) => false);
  }
}
