import 'package:repositories/repositories.dart';

abstract class IRidersRepo {
  Stream<List<History>> get history;
  Future<void> fetchAllHistory();
  Future<HistoryDetail> fetchHistoryDetail(String id);
  Future<void> updateOrderPaymentStatus();
  Future<void> updateOrderStatus();
  void dispose();
}