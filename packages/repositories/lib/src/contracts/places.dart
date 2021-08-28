import 'package:repositories/repositories.dart';
import 'package:repositories/src/models/place_detail.dart';

abstract class IPlacesRepo {
  Future<List<Prediction>> searchForPlaces(String keyword);
  Future<PlaceDetail> fetchDetail(String placeId);
}