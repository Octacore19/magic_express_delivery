import 'package:repositories/src/contracts/contracts.dart';
import 'package:repositories/src/impl/misc.dart';
import 'package:repositories/src/models/charges.dart';
import 'package:services/services.dart';

class MiscRepo implements IMiscRepo {
  MiscRepo({required ApiProvider api}) {
    _repo = MiscRepoImpl(api: api);
  }

  late IMiscRepo _repo;

  @override
  Charges get charges => _repo.charges;

  @override
  Future<void> fetchChargesFromService() => _repo.fetchChargesFromService();

  @override
  Future<void> updateAvailability() => _repo.updateAvailability();

  @override
  Future<void> updateDeviceToken(String token) =>
      _repo.updateDeviceToken(token);

  @override
  Future<void> updateUserLocation(double latitude, double longitude) =>
      _repo.updateUserLocation(latitude, longitude);

  @override
  Future<String> updateUserPassword(
    String password,
    String newPassword,
    String confirmPassword,
  ) =>
      _repo.updateUserPassword(password, newPassword, confirmPassword);
}