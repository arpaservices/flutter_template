import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../../utils/core/constant/api_endpoints.dart';
import '../../../utils/support/logging_interceptor.dart';

class ApiServiceTest extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final mockResponse = await _getMockResponse(options.path);
    printLongString("Test API Called for path: ${options.baseUrl}");
    printLongString("Test API Called for response: ${mockResponse}");
    if (mockResponse != null) {
      handler.resolve(Response(
        // headers: Headers.fromMap({
        //   'content-type': ['application/json'],
        //   'access-control-allow-origin': ['*'], // optional, simulating CORS response
        //   'access-control-allow-methods': ['GET, POST, OPTIONS'],
        // }),
        requestOptions: options,
        data: json.decode(mockResponse),
        statusCode: 200,
        statusMessage: 'OK',
      ));
    } else {
      handler.next(
          options); // continue with the real request if no mock response is found
    }
  }

  Future<String?> _getMockResponse(String path) async {
    try {
      if (path == (ApiEndPoints.GET_USER_BY_UID)) {
        return await loadTestJsonAsset('get_user_by_uid_response.json');
      } else if (path == (ApiEndPoints.GET_USER_BY_UID)) {
        return await loadTestJsonAsset('get_app_settings_response.json');
      } else {
        return null;
      }
    } catch (e) {
      print("mock error $e");
      return null;
    }
    return null;
  }
}

Future<String> loadTestJsonAsset(String fileName) async {
  return rootBundle.loadString('test/api_response_test/$fileName');
}
