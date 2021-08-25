import 'package:services/services.dart';
import 'package:services/src/contracts/contracts.dart';

class PlacesService implements IPlacesService {
  PlacesService(this._service);

  final IPlacesService _service;

  @override
  Future<DioResponse> fetchPlaceDetail(String id) =>
      _service.fetchPlaceDetail(id);

  @override
  Future<DioResponse> searchForPlace(
          String keyword, Map<String, dynamic> queryParams) =>
      _service.searchForPlace(keyword, queryParams);
}
