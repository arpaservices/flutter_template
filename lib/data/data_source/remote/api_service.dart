


import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import '../../../utils/core/constant/constants.dart';


part 'api_service.g.dart';

@RestApi(baseUrl: Constants.SUPER_STAR_APP_BASE_URL)
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

}
