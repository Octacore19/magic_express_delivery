import 'package:services/services.dart';
import 'package:services/src/contracts/contracts.dart';
import 'package:services/src/impl/google_places.dart';

class PlacesService implements IPlacesService {
  PlacesService({required ApiProvider api}) {
    _service = PlaceServiceImpl(api.googleInstance);
  }

  late IPlacesService _service;

  @override
  Future<DioResponse> fetchPlaceDetail(Map<String, dynamic> queryParams) =>
      _service.fetchPlaceDetail(queryParams);

  @override
  Future<DioResponse> searchForPlace(Map<String, dynamic> queryParams) =>
      _service.searchForPlace(queryParams);

  @override
  Future<DioResponse> getDistanceMatrix(Map<String, dynamic> queryParams) =>
      _service.getDistanceMatrix(queryParams);
}
