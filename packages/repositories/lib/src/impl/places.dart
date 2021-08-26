import 'package:repositories/repositories.dart';
import 'package:repositories/src/contracts/contracts.dart';
import 'package:services/services.dart';

class PlacesImpl implements IPlaces {
  PlacesImpl(this._service);

  final PlacesService _service;

  @override
  Future<List<Prediction>> searchForPlaces(String keyword) async {
    try {
      final query = {
        'input': keyword,
        'types': 'address',
        'components': 'country:ng',
        'key': ApiConstants.GOOGLE_PLACES_KEY
      };
      final res = await _service.searchForPlace(query);
      if (!res.success) throw Exception(res.message);
      final data = BaseResponse.fromJson(res.data).data;
      final placesRes =
          (data as List).map((e) => PredictionResponse.fromJson(e)).toList();
      if (placesRes.isEmpty) throw Exception('No result found');
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
}
