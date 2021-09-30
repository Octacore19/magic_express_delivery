import 'package:repositories/repositories.dart';
import 'package:repositories/src/contracts/contracts.dart';
import 'package:repositories/src/impl/impl.dart';
import 'package:repositories/src/models/new_order.dart';
import 'package:services/services.dart';

class UsersRepo implements IUsersRepo {
  UsersRepo({required ApiProvider api}) : _repo = UsersRepoImpl(api: api);
  final IUsersRepo _repo;

  @override
  Future<void> createOrder(Map<String, dynamic> data) =>
      _repo.createOrder(data);

  @override
  Future<void> fetchAllHistory() => _repo.fetchAllHistory();

  @override
  Future<OrderDetail> fetchHistoryDetail(String id) =>
      _repo.fetchHistoryDetail(id);

  @override
  Future<void> verifyPayment(String reference, String orderId) =>
      _repo.verifyPayment(reference, orderId);

  @override
  void dispose() => _repo.dispose();

  @override
  Stream<NewOrder> get order => _repo.order;

  @override
  Charges get charges => _repo.charges;

  @override
  Stream<List<Order>> get history => _repo.history;
}
