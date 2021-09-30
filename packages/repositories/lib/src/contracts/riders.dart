import 'package:repositories/repositories.dart';

abstract class IRidersRepo {
  Stream<List<Order>> get history;
  Future<void> fetchAllHistory();
  Future<OrderDetail> fetchHistoryDetail(String id);
  Future<void> updateOrderPaymentStatus();
  Future<void> updateOrderStatus();
  void dispose();
}