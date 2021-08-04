import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:services/src/commons/commons.dart';
import 'package:services/src/contracts/contracts.dart';
import 'package:services/src/models/models.dart';

class AuthImpl implements IAuthenticationService {
  final Dio _dio;

  AuthImpl(this._dio);

  @override
  Future<BaseResponse> loginUser(Map<String, String> data) async {
    final baseResponse = await _dio.post(
      ApiEndpoints.LOGIN_USER,
      data: FormData.fromMap(data),
      options: Options(
        headers: {"no_token": true},
      ),
    );
    final response = BaseResponse.fromJson(baseResponse.data);
    log('Login service response: $response');
    return response;
  }

  @override
  Future<BaseResponse> registerUser(Map<String, dynamic> data) async {
    final baseResponse = await _dio.post(
      ApiEndpoints.REGISTER_USER,
      data: FormData.fromMap(data),
      options: Options(
        headers: {"no_token": true},
      ),
    );
    final response = BaseResponse.fromJson(baseResponse.data);
    log('Register service response: $response');
    return response;
  }
}
