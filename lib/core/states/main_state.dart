import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:the_green_manual/core/http/http.dart';

class MainState extends ChangeNotifier {
  Dio dio = getHttp();

  MainState() {}
}
