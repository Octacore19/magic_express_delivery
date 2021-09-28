import 'package:services/src/models/models.dart';

abstract class IOrdersService {
  Future<DioResponse> createOrder(Map<String, dynamic> data);

  Future<DioResponse> fetchUserOrders();

  Future<DioResponse> fetchUserOrderDetail(String id);

  Future<DioResponse> fetchRiderOrders();

  Future<DioResponse> fetchRiderOrderDetail(String id);

  Future<DioResponse> verifyPaymentStatus(Map<String, String> query);

  Future<DioResponse> updateOrderPaymentStatus(String orderId);

  Future<DioResponse> updateOrderStatus(String orderId, Map<String, dynamic> data);

  Future<DioResponse> trackOrder(Map<String, dynamic> query);
}