import 'package:repositories/repositories.dart';
import 'package:repositories/src/contracts/contracts.dart';
import 'package:repositories/src/models/order.dart';
import 'package:repositories/src/models/order_detail.dart';
import 'package:services/services.dart';

class RidersRepoImpl implements IRidersRepo {
  RidersRepoImpl({required ApiProvider api}) {
    _service = OrdersService(api: api);
  }

  final _controller = BehaviorSubject<List<Order>>.seeded(List.empty());
  final _detailController = BehaviorSubject<OrderDetail>.seeded(OrderDetail.empty());
  late OrdersService _service;

  @override
  Stream<List<Order>> get history => _controller.stream;

  @override
  Stream<OrderDetail> get detail => _detailController.stream;

  @override
  Future<void> fetchAllHistory() async {
    try {
      final res = await _service.fetchRiderOrders();
      if (!res.success) throw RequestFailureException(res.message);
      final data = BaseResponse.fromJson(res.data).data;
      if (data == null) throw NoDataException();
      final list =
      (data as List).map((e) => HistoryResponse.fromJson(e)).toList();
      if (list.isEmpty) throw NoElementException();
      final history = list.map((e) => Order.fromResponse(e)).toList();
      _controller.sink.add(history);
      return;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> fetchHistoryDetail(String id) async {
    try {
      final res = await _service.fetchRiderOrderDetail(id);
      if (!res.success) throw RequestFailureException(res.message);
      final data = BaseResponse.fromJson(res.data).data;
      if (data == null) throw NoDataException();
      final response = HistoryDetailResponse.fromJson(data);
      _detailController.sink.add(OrderDetail.fromResponse(response));
      return ;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> updateOrderPaymentStatus(String id) async {
    try {
      final res = await _service.updateOrderPaymentStatus(id);
      if (!res.success) throw RequestFailureException(res.message);
      final data = BaseResponse.fromJson(res.data).message;
      if (data == null) throw NoDataException();
      return;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> updateOrderStatus(String id, OrderStatus status) async {
    try {
      final d = {'order_status': status.value};
      final res = await _service.updateOrderStatus(id, d);
      if (!res.success) throw RequestFailureException(res.message);
      final data = BaseResponse.fromJson(res.data).message;
      if (data == null) throw NoDataException();
      return;
    } catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    _controller.close();
    _detailController.close();
  }
}
