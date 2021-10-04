import 'package:repositories/src/contracts/contracts.dart';
import 'package:repositories/src/impl/impl.dart';
import 'package:repositories/src/models/models.dart';
import 'package:services/services.dart';

class RidersRepo implements IRidersRepo {
  RidersRepo({required ApiProvider api}) : _repo = RidersRepoImpl(api: api);
  final IRidersRepo _repo;

  @override
  void dispose() => _repo.dispose();

  @override
  Future<void> fetchAllHistory() => _repo.fetchAllHistory();

  @override
  Future<void> fetchHistoryDetail(String id) =>
      _repo.fetchHistoryDetail(id);

  @override
  Stream<List<Order>> get history => _repo.history;

  @override
  Stream<OrderDetail> get detail => _repo.detail;

  @override
  Future<void> updateOrderPaymentStatus(String id) => _repo.updateOrderPaymentStatus(id);

  @override
  Future<void> updateOrderStatus(String id, OrderStatus status) => _repo.updateOrderStatus(id, status);
}
