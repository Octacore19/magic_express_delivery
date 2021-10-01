import 'package:repositories/repositories.dart';

abstract class IMiscRepo {
  Future<void> updateUserLocation(double latitude, double longitude, String address);

  Future<void> updateDeviceToken(String token);

  Future<String> updateUserPassword(
    String password,
    String newPassword,
    String confirmPassword,
  );

  Future<void> updateAvailability(bool value);

  Future<void> fetchChargesFromService();

  Charges get charges;
}
