import 'package:dio/dio.dart';
import 'package:services/src/commons/commons.dart';
import 'package:services/src/contracts/orders.dart';
import 'package:services/src/models/models.dart';

class OrdersImpl implements IOrdersService {
  final Dio _dio;

  OrdersImpl(this._dio);

  @override
  Future<DioResponse> createOrder(Map<String, dynamic> data) async {
    try {
      final baseResponse = await _dio.post(
        ApiEndpoints.CREATE_ORDER,
        data: FormData.fromMap(data),
      );
      return DioResponse.fromJson(baseResponse.data);
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<DioResponse> fetchUserOrders() async {
    try {
      final baseResponse = await _dio.get(ApiEndpoints.USER_ORDERS);
      return DioResponse.fromJson(baseResponse.data);
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<DioResponse> fetchUserOrderDetail(String id) async {
    try {
      final baseResponse =
          await _dio.get(ApiEndpoints.USER_ORDER_DETAIL + '/$id');
      return DioResponse.fromJson(baseResponse.data);
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<DioResponse> fetchRiderOrders() async {
    try {
      final baseResponse = await _dio.get(ApiEndpoints.RIDER_ORDERS);
      return DioResponse.fromJson(baseResponse.data);
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<DioResponse> fetchRiderOrderDetail(String id) async {
    try {
      final baseResponse =
          await _dio.get(ApiEndpoints.RIDER_ORDER_DETAIL + '/$id');
      return DioResponse.fromJson(baseResponse.data);
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<DioResponse> verifyPaymentStatus(Map<String, String> query) async {
    try {
      final baseResponse = await _dio.get(
        ApiEndpoints.VERIFY_PAYMENT,
        queryParameters: query,
      );
      return DioResponse.fromJson(baseResponse.data);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<DioResponse> getCharges() async {
    try {
      final baseResponse = await _dio.get(ApiEndpoints.CHARGES);
      return DioResponse.fromJson(baseResponse.data);
    } catch (e) {
      throw e;
    }
  }
}
