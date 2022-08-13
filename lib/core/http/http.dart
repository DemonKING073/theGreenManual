import 'package:dio/dio.dart';
import 'package:the_green_manual/core/services/local_storage_services.dart';
import 'package:the_green_manual/core/services/toast_service.dart';
import 'package:the_green_manual/main.dart';

class CustomError extends DioError {
  String msg;
  CustomError(DioError error, this.msg)
      : super(
          requestOptions: error.requestOptions,
          error: error.error,
          response: error.response,
          type: error.type,
        );
}

Dio getHttp() {
  Dio dio = Dio();

  dio.options.baseUrl = "https://api-gmanual.herokuapp.com/api/";
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      String token =
          LocalStorageService().read(LocalStorageKeys.accessToken) ?? "";
      if (token.isNotEmpty) {
        options.headers['Authorization'] = "Bearer $token";
      }

      return handler.next(options);
    },
    onResponse: (response, handler) {
      return handler.next(response);
    },
    onError: (DioError e, handler) {
      if (e.type == DioErrorType.response) {
        if (e.response!.statusCode == 401) {
          //Unauthorized
          LocalStorageService().clear(LocalStorageKeys.accessToken);
          Future.delayed(const Duration(milliseconds: 100), () {
            navigatorKey.currentState!
                .pushNamedAndRemoveUntil("/login", (route) => false);
          });
        }
      }
      String message = "Something went wrong";
      switch (e.type) {
        case DioErrorType.cancel:
          message = "Request Cancelled";
          break;
        case DioErrorType.response:
          if (e.response?.data is Map<String, dynamic>) {
            message = (e.response!.data['errors'] as List)
                .map((err) => err['message'])
                .toList()
                .join(", ");
          } else {
            message = "API didn't return JSON";
          }

          break;
        case DioErrorType.receiveTimeout:
          message = "Receive Timeout";
          break;
        case DioErrorType.sendTimeout:
          message = "Send Timeout";
          break;
        case DioErrorType.other:
          message = "Something went wrong";
          break;
        case DioErrorType.connectTimeout:
          message = "Connect Timeout";
          break;
      }
      ToastService().e(message, duration: const Duration(seconds: 10));

      return handler.next(CustomError(e, message));
    },
  ));

  return dio;
}
