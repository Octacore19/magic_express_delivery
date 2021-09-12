import 'package:repositories/repositories.dart';
import 'package:repositories/src/contracts/contracts.dart';
import 'package:repositories/src/models/place_detail.dart';
import 'package:services/services.dart';
import 'package:uuid/uuid.dart';

class PlacesRepoImpl implements IPlacesRepo {
  PlacesRepoImpl(ApiProvider api) {
    _service = PlacesService(api: api);
  }

  final Uuid _uuid = Uuid();

  late PlacesService _service;
  String _sessionToken = '';

  @override
  Future<List<Prediction>> searchForPlaces(String keyword) async {
    if (_sessionToken.isEmpty) _sessionToken = _uuid.v4();
    try {
      final query = {
        'input': keyword,
        'types': 'address',
        'components': 'country:ng',
        'sessiontoken': _sessionToken,
        'key': ApiConstants.GOOGLE_PLACES_KEY
      };
      final res = await _service.searchForPlace(query);
      if (!res.success) throw RequestFailureException(res.message);
      final data = BaseResponse.fromJson(res.data).data;
      if (data == null) throw NoDataException();
      final placesRes =
          (data as List).map((e) => PredictionResponse.fromJson(e)).toList();
      if (placesRes.isEmpty) throw NoElementException('No result found');
      return placesRes
          .map((e) => Prediction(
                id: e.placeId ?? '',
                description: e.description ?? '',
              ))
          .toList();
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<PlaceDetail> fetchDetail(String placeId) async {
    try {
      final query = {
        'place_id': placeId,
        'fields': 'formatted_address,name,geometry',
        'sessiontoken': _sessionToken,
        'key': ApiConstants.GOOGLE_PLACES_KEY
      };
      final res = await _service.fetchPlaceDetail(query);
      if (!res.success) throw RequestFailureException(res.message);
      final data = BaseResponse.fromJson(res.data).data;
      if (data == null) throw NoDataException();
      final placeDetailRes = PlaceDetailResponse.fromJson(data);
      _sessionToken = '';
      return PlaceDetail.fromResponse(placeDetailRes);
    } catch(e) {
      throw e;
    }
  }
}
