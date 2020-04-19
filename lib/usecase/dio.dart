import 'package:dio/dio.dart';

class CustomDio {
  Dio _dio;
  Dio get dio {
    if (_dio == null) {
      _dio = Dio();
    }
    return _dio;
  }
}
