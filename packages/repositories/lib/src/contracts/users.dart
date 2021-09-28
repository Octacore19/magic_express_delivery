import 'package:repositories/repositories.dart';

abstract class IUsersRepo {
  Stream<Order> get order;
  Stream<List<History>> get history;
  Future<void> createOrder(Map<String, dynamic> data);
  Future<void> fetchAllHistory();
  Future<HistoryDetail> fetchHistoryDetail(String id);
  Future<void> verifyPayment(String reference, String orderId);
  Charges get charges;
  void dispose();
}