import 'package:repositories/repositories.dart';

abstract class IOrdersRepo {
  Stream<Order> get order;
  Stream<Charges> get charges;
  Stream<List<History>> get history;
  Future<void> createOrder(Map<String, dynamic> data);
  Future<void> fetchAllHistory();
  Future<HistoryDetail> fetchHistoryDetail(String id);
  Future<void> getCharges();
  void dispose();
}