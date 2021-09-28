import 'package:services/services.dart';

abstract class IMiscService {
  Future<DioResponse> updateUserLocation(Map<String, dynamic> data);

  Future<DioResponse> updateDeviceToken(Map<String, dynamic> data);

  Future<DioResponse> updateUserPassword(Map<String, dynamic> data);

  Future<DioResponse> updateAvailability();

  Future<DioResponse> getCharges();
}
