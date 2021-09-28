import 'package:repositories/repositories.dart';

abstract class IMiscRepo {
  Future<void> updateUserLocation(double latitude, double longitude);

  Future<void> updateDeviceToken(String token);

  Future<String> updateUserPassword(
    String password,
    String newPassword,
    String confirmPassword,
  );

  Future<void> updateAvailability();

  Future<void> fetchChargesFromService();

  Charges get charges;
}
