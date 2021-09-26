import 'package:repositories/repositories.dart';
import 'package:repositories/src/contracts/contracts.dart';
import 'package:services/services.dart';

class UsersRepoImpl implements IUsersRepo {
  UsersRepoImpl({required ApiProvider api})
      : _service = OrdersService(api: api);

  final OrdersService _service;

  final _orderController = BehaviorSubject<Order>.seeded(Order.empty());
  final _historyController =
      BehaviorSubject<List<History>>.seeded(List.empty());

  Charges? _charges;

  @override
  Stream<Order> get order => _orderController.stream;

  @override
  Stream<List<History>> get history => _historyController.stream;

  @override
  Charges get charges => _charges ?? Charges.empty();

  @override
  Future<void> createOrder(Map<String, dynamic> data) async {
    try {
      final res = await _service.createOrder(data);
      if (!res.success) throw RequestFailureException(res.message);
      final d = BaseResponse.fromJson(res.data).data;
      if (d == null) throw NoDataException();
      final orderResponse = OrderResponse.fromJson(d);
      final order = Order.fromResponse(orderResponse);
      _orderController.sink.add(order);
      fetchAllHistory();
      return;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> fetchAllHistory() async {
    try {
      final res = await _service.fetchUserOrders();
      if (!res.success) throw RequestFailureException(res.message);
      final data = BaseResponse.fromJson(res.data).data;
      if (data == null) throw NoDataException();
      final list =
          (data as List).map((e) => HistoryResponse.fromJson(e)).toList();
      if (list.isEmpty) throw NoElementException();
      final history = list.map((e) => History.fromResponse(e)).toList();
      _historyController.sink.add(history);
      return;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<HistoryDetail> fetchHistoryDetail(String id) async {
    try {
      final res = await _service.fetchUserOrderDetail(id);
      if (!res.success) throw RequestFailureException(res.message);
      final data = BaseResponse.fromJson(res.data).data;
      if (data == null) throw NoDataException();
      final response = HistoryDetailResponse.fromJson(data);
      return HistoryDetail.fromResponse(response);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Object> verifyPayment(String reference) async {
    try {
      final query = {'reference': reference};
      final res = await _service.verifyPaymentStatus(query);
      if (!res.success) throw RequestFailureException(res.message);
      final data = BaseResponse.fromJson(res.data).data;
      if (data == null) throw NoDataException();
      return data;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> getCharges() async {
    try {
      final res = await _service.getCharges();
      if (!res.success) throw RequestFailureException(res.message);
      final data = BaseResponse.fromJson(res.data).data;
      if (data == null) throw NoDataException();
      final response = ChargesResponse.fromJson(data);
      _charges = Charges.fromResponse(response);
      return;
    } catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    _orderController.close();
    _historyController.close();
  }
}
