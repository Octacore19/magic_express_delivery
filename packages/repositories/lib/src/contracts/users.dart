import 'package:repositories/repositories.dart';

abstract class IUsersRepo {
  Stream<NewOrder> get order;
  Stream<List<Order>> get history;
  Future<void> createOrder(Map<String, dynamic> data);
  Future<void> fetchAllHistory();
  Future<OrderDetail> fetchHistoryDetail(String id);
  Future<void> verifyPayment(String reference, String orderId);
  void dispose();
  void initRepo();
}