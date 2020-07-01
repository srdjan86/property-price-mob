import 'package:dio/dio.dart';

class CustomDio {
  Dio _dio;
  Dio get dio {
    if (_dio == null) {
      _dio = Dio();
    }
    return _dio;
  }

  static CustomDio _singleton;
  CustomDio get instance {
    if (_singleton == null) {
      _singleton = CustomDio();
    }
    return _singleton;
  }
}
