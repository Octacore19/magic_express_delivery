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
  Future<HistoryDetail> fetchHistoryDetail(String id) =>
      _repo.fetchHistoryDetail(id);

  @override
  Stream<List<History>> get history => _repo.history;

  @override
  Future<void> updateOrderPaymentStatus() => _repo.updateOrderPaymentStatus();

  @override
  Future<void> updateOrderStatus() => _repo.updateOrderStatus();
}
