import 'package:services/services.dart';
import 'package:services/src/contracts/contracts.dart';
import 'package:services/src/impl/impl.dart';
import 'package:services/src/models/dio_response.dart';

class MiscService implements IMiscService {
  MiscService({required ApiProvider api})
      : _service = MiscServiceImpl(api.mainInstance);
  final MiscServiceImpl _service;

  @override
  Future<DioResponse> getCharges() => _service.getCharges();

  @override
  Future<DioResponse> updateAvailability() => _service.updateAvailability();

  @override
  Future<DioResponse> updateDeviceToken(Map<String, dynamic> data) =>
      _service.updateDeviceToken(data);

  @override
  Future<DioResponse> updateUserLocation(Map<String, dynamic> data) =>
      _service.updateUserLocation(data);

  @override
  Future<DioResponse> updateUserPassword(Map<String, dynamic> data) =>
      _service.updateUserPassword(data);
}
