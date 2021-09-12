import 'package:repositories/repositories.dart';
import 'package:repositories/src/contracts/contracts.dart';
import 'package:repositories/src/impl/impl.dart';
import 'package:repositories/src/models/order.dart';
import 'package:services/services.dart';

class OrdersRepo implements IOrdersRepo {
  OrdersRepo({required ApiProvider api}) : _repo = OrdersRepoImpl(api: api);
  final IOrdersRepo _repo;

  @override
  Future<void> createOrder(Map<String, dynamic> data) => _repo.createOrder(data);

  @override
  Future<void> fetchAllHistory() => _repo.fetchAllHistory();

  @override
  Future<HistoryDetail> fetchHistoryDetail(String id) => _repo.fetchHistoryDetail(id);

  @override
  void dispose() => _repo.dispose();

  @override
  Stream<Order> get order => _repo.order;

  @override
  Stream<List<History>> get history => _repo.history;
}
