import 'package:get_storage/get_storage.dart';

class LocalStorageKeys {
  static const accessToken = "AccessToken";
  static const refreshToken = "RefreshToken";
  static const leadInteraction = "leadInteraction";
  static const leadPersistance = "leadPersistance";
  static const dealPersistance = "dealPersistance";
  static const taskAndAct = "taskAndAct";
  static const pipeline = "pipeline";
  static const dealStatus = "dealStatus";
  static const leadRating = "leadRating";
  static const filterCreatedDate = "filterCreatedDate";
  static const taskFilterType = "taskFilterType";
  static const taskFilterPriority = "taskFilterPriority";
  static const privacyPolicy = "privacyPolicy";
}

class LocalStorageService {
  final _box = GetStorage();

  static Future<void> init() {
    return GetStorage.init();
  }

  String? read(key) {
    return _box.read(key);
  }

  Future<void> write(String key, dynamic value) {
    return _box.write(key, value);
  }

  Future<void> clear(String key) {
    return _box.remove(key);
  }

  bool isEmpty(String key) {
    return _box.read(key) == null;
  }

  bool isNotEmpty(String key) {
    return _box.read(key) != null;
  }
}
