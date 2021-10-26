import 'package:repositories/repositories.dart';
import 'package:repositories/src/contracts/contracts.dart';
import 'package:services/services.dart';

class UsersRepoImpl implements IUsersRepo {
  UsersRepoImpl({required ApiProvider api})
      : _service = OrdersService(api: api);

  final OrdersService _service;

  final _orderController = BehaviorSubject<NewOrder>.seeded(NewOrder.empty());
  final _historyController =
      BehaviorSubject<List<Order>>.seeded(List.empty());


  @override
  Stream<NewOrder> get order => _orderController.stream;

  @override
  Stream<List<Order>> get history => _historyController.stream;

  @override
  void initRepo() {
    if (!_historyController.hasValue) {
      fetchAllHistory();
    }
  }

  @override
  Future<void> createOrder(Map<String, dynamic> data) async {
    try {
      final res = await _service.createOrder(data);
      if (!res.success) throw RequestFailureException(res.message);
      final d = BaseResponse.fromJson(res.data).data;
      if (d == null) throw NoDataException();
      final orderResponse = OrderResponse.fromJson(d);
      final order = NewOrder.fromResponse(orderResponse);
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
      final history = list.map((e) => Order.fromResponse(e)).toList();
      _historyController.sink.add(history);
      return;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<OrderDetail> fetchHistoryDetail(String id) async {
    try {
      final res = await _service.fetchUserOrderDetail(id);
      if (!res.success) throw RequestFailureException(res.message);
      final data = BaseResponse.fromJson(res.data).data;
      if (data == null) throw NoDataException();
      final response = HistoryDetailResponse.fromJson(data);
      return OrderDetail.fromResponse(response);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> verifyPayment(String reference, String orderId) async {
    try {
      final query = {'reference': reference, 'order_id': orderId};
      final res = await _service.verifyPaymentStatus(query);
      if (!res.success) throw RequestFailureException(res.message);
      final msg = BaseResponse.fromJson(res.data).message;
      if (msg == null) throw NoDataException();
      return;
    } catch (e) {
      throw e;
    }
  }

  Future<void> getCharges() async {

  }

  @override
  void dispose() {
    _orderController.close();
    _historyController.close();
  }
}
