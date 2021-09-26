import 'package:services/services.dart';
import 'package:services/src/contracts/contracts.dart';
import 'package:services/src/impl/impl.dart';
import 'package:services/src/models/dio_response.dart';

class OrdersService implements IOrdersService {
  OrdersService({required ApiProvider api})
      : _orders = OrdersImpl(api.mainInstance);
  final OrdersImpl _orders;

  @override
  Future<DioResponse> createOrder(Map<String, dynamic> data) =>
      _orders.createOrder(data);

  @override
  Future<DioResponse> fetchUserOrders() => _orders.fetchUserOrders();

  @override
  Future<DioResponse> fetchUserOrderDetail(String id) =>
      _orders.fetchUserOrderDetail(id);

  @override
  Future<DioResponse> fetchRiderOrders() => _orders.fetchRiderOrders();

  @override
  Future<DioResponse> fetchRiderOrderDetail(String id) =>
      _orders.fetchRiderOrderDetail(id);

  @override
  Future<DioResponse> verifyPaymentStatus(Map<String, String> query) =>
      _orders.verifyPaymentStatus(query);

  @override
  Future<DioResponse> getCharges() => _orders.getCharges();
}
