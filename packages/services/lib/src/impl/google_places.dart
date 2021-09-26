import 'package:dio/dio.dart';
import 'package:services/services.dart';
import 'package:services/src/commons/commons.dart';
import 'package:services/src/contracts/contracts.dart';

class PlaceServiceImpl implements IPlacesService {
  PlaceServiceImpl(this._dio);

  final Dio _dio;

  @override
  Future<DioResponse> fetchPlaceDetail(Map<String, dynamic> queryParams) async {
    try {
      final baseResponse = await _dio.get(
        ApiEndpoints.DETAIL_PLACE,
        queryParameters: queryParams,
      );
      return DioResponse.fromJson(baseResponse.data);
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<DioResponse> searchForPlace(Map<String, dynamic> queryParams) async {
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

  @override
  Future<DioResponse> getDistanceMatrix(
      Map<String, dynamic> queryParams) async {
    try {
      final baseResponse = await _dio.get(
        ApiEndpoints.DISTANCE_MATRIX,
        queryParameters: queryParams,
      );
      return DioResponse.fromJson(baseResponse.data);
    } on Exception catch (e) {
      throw e;
    }
  }
}
