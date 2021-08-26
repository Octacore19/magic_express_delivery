import 'package:services/services.dart';
import 'package:services/src/contracts/contracts.dart';

class PlacesService implements IPlacesService {
  PlacesService(this._service);

  final IPlacesService _service;

  @override
  Future<DioResponse> fetchPlaceDetail(Map<String, dynamic> queryParams) =>
      _service.fetchPlaceDetail(queryParams);

  @override
  Future<DioResponse> searchForPlace(Map<String, dynamic> queryParams) =>
      _service.searchForPlace(queryParams);
}
