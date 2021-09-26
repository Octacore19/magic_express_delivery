import 'package:services/services.dart';

abstract class IPlacesService {
  Future<DioResponse> searchForPlace(Map<String, dynamic> queryParams);

  Future<DioResponse> fetchPlaceDetail(Map<String, dynamic> queryParams);

  Future<DioResponse> getDistanceMatrix(Map<String, dynamic> queryParams);
}