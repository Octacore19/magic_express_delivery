import 'package:dio/dio.dart';
import 'package:services/services.dart';
import 'package:services/src/commons/commons.dart';
import 'package:services/src/contracts/contracts.dart';

class PlaceServiceImpl implements IPlacesService {

  PlaceServiceImpl(this._dio) {
    _dio.options.baseUrl = ApiConstants.GOOGLE_BASE_URL;
  }

  final Dio _dio;

  @override
  Future<DioResponse> fetchPlaceDetail(String id) async {
    // TODO: implement searchForPlace
    throw UnimplementedError();
  }

  @override
  Future<DioResponse> searchForPlace(String keyword, Map<String, dynamic> queryParams) async {
    try {
      final baseResponse = await _dio.get(
          ApiEndpoints.SEARCH_PLACE,
          queryParameters: queryParams,
      );
      return DioResponse.fromJson(baseResponse.data);
    } on Exception catch (e) {
      throw e;
    }
  }

}