import 'package:repositories/repositories.dart';

abstract class IRidersRepo {
  Stream<List<Order>> get history;
  Stream<OrderDetail> get detail;
  Future<void> fetchAllHistory();
  Future<void> fetchHistoryDetail(String id);
  Future<void> updateOrderPaymentStatus(String id);
  Future<void> updateOrderStatus(String id, OrderStatus status);
  void dispose();
}