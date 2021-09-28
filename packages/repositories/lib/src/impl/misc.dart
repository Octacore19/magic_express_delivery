import 'package:repositories/repositories.dart';
import 'package:repositories/src/contracts/contracts.dart';
import 'package:repositories/src/models/charges.dart';
import 'package:services/services.dart';

class MiscRepoImpl implements IMiscRepo {
  MiscRepoImpl({required ApiProvider api}) {
    _service = MiscService(api: api);
  }

  late MiscService _service;
  Charges? _charges;

  @override
  Future<void> fetchChargesFromService() async {
    try {
      final res = await _service.getCharges();
      if (!res.success) throw RequestFailureException(res.message);
      final data = BaseResponse.fromJson(res.data).data;
      if (data == null) throw NoDataException();
      final response = ChargesResponse.fromJson(data);
      _charges = Charges.fromResponse(response);
      return;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> updateAvailability() async {
    try {
      final res = await _service.updateAvailability();
      if (!res.success) throw RequestFailureException(res.message);
      final data = BaseResponse.fromJson(res.data).data;
      if (data == null) throw NoDataException();
      return;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> updateDeviceToken(String token) async {
    try {
      final d = {'token': token};
      final res = await _service.updateDeviceToken(d);
      if (!res.success) throw RequestFailureException(res.message);
      final data = BaseResponse.fromJson(res.data).message;
      if (data == null) throw NoDataException();
      return;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> updateUserLocation(double latitude, double longitude) async {
    try {
      final d = {
        'location': {
          'latitude': latitude,
          'longitude': longitude,
        }
      };
      final res = await _service.updateUserPassword(d);
      if (!res.success) throw RequestFailureException(res.message);
      final data = BaseResponse.fromJson(res.data).message;
      if (data == null) throw NoDataException();
      return;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<String> updateUserPassword(
    String password,
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      final d = {
        'old_password': password,
        'password': newPassword,
        'password_confirmation': confirmPassword,
      };
      final res = await _service.updateUserPassword(d);
      if (!res.success) throw RequestFailureException(res.message);
      final data = BaseResponse.fromJson(res.data).message;
      if (data == null) throw NoDataException();
      return data;
    } catch (e) {
      throw e;
    }
  }

  @override
  Charges get charges => _charges ?? Charges.empty();
}
