import 'package:dio/dio.dart';
import '../../../data/data_source/test/api_service_test.dart';

import '../config/environment.dart';
import 'logging_interceptor.dart';

Dio createDio() {
  final dio = Dio();
  dio.interceptors.add(LoggingInterceptor());
  dio.options.headers = {
    'Accept': 'application/json',
  };
  if (Config.environment == Environment.mock) {
    dio.interceptors.add(ApiServiceTest());
  }
  return dio;
}
