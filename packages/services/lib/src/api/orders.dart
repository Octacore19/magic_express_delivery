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
  Future<DioResponse> fetchOrders() => _orders.fetchOrders();

  @override
  Future<DioResponse> fetchOrderDetail(String id) => _orders.fetchOrderDetail(id);

  @override
  Future<DioResponse> getCharges() => _orders.getCharges();
}
