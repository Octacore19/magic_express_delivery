import 'package:services/services.dart';

abstract class IPlacesService {
  Future<DioResponse> searchForPlace(String keyword, Map<String, dynamic> queryParams);

  Future<DioResponse> fetchPlaceDetail(String id);
}