import 'package:dio/dio.dart';
import 'package:services/src/commons/api_endpoints.dart';
import 'package:services/src/contracts/contracts.dart';
import 'package:services/src/models/dio_response.dart';

class NotificationServiceImpl implements INotificationService {
  final Dio _dio;

  NotificationServiceImpl(this._dio);

  @override
  Future<DioResponse> getAllNotifications() async {
    try {
      final baseResponse = await _dio.get(ApiEndpoints.ALL_NOTIFICATIONS);
      return DioResponse.fromJson(baseResponse.data);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<DioResponse> getReadNotifications() async {
    try {
      final baseResponse = await _dio.get(ApiEndpoints.READ_NOTIFICATIONS);
      return DioResponse.fromJson(baseResponse.data);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<DioResponse> getUnreadNotifications() async {
    try {
      final baseResponse = await _dio.get(ApiEndpoints.UNREAD_NOTIFICATIONS);
      return DioResponse.fromJson(baseResponse.data);
    } catch (e) {
      throw e;
    }
  }
}