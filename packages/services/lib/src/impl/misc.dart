import 'package:dio/dio.dart';
import 'package:services/src/commons/commons.dart';
import 'package:services/src/contracts/contracts.dart';
import 'package:services/src/models/dio_response.dart';

class MiscServiceImpl implements IMiscService {
  final Dio _dio;

  MiscServiceImpl(this._dio);

  @override
  Future<DioResponse> getCharges() async {
    try {
      final baseResponse = await _dio.get(ApiEndpoints.CHARGES);
      return DioResponse.fromJson(baseResponse.data);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<DioResponse> updateAvailability(bool value) async {
    try {
      final baseResponse = await _dio.post(
        ApiEndpoints.RIDER_AVAILABILITY,
        data: {'is_available': value},
      );
      return DioResponse.fromJson(baseResponse.data);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<DioResponse> updateDeviceToken(Map<String, dynamic> data) async {
    try {
      final baseResponse = await _dio.put(
        ApiEndpoints.DEVICE_TOKEN,
        data: data,
      );
      return DioResponse.fromJson(baseResponse.data);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<DioResponse> updateUserLocation(Map<String, dynamic> data) async {
    try {
      final baseResponse = await _dio.put(
        ApiEndpoints.USER_LOCATION,
        data: data,
      );
      return DioResponse.fromJson(baseResponse.data);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<DioResponse> updateUserPassword(Map<String, dynamic> data) async {
    try {
      final baseResponse = await _dio.put(
        ApiEndpoints.UPDATE_USER_PASSWORD,
        data: data,
      );
      return DioResponse.fromJson(baseResponse.data);
    } catch (e) {
      throw e;
    }
  }
}
