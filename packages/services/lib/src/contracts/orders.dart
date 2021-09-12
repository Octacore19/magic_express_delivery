import 'package:services/src/models/models.dart';

abstract class IOrdersService {
  Future<DioResponse> createOrder(Map<String, dynamic> data);

  Future<DioResponse> fetchOrders();

  Future<DioResponse> fetchOrderDetail(String id);

  Future<DioResponse> getCharges();
}