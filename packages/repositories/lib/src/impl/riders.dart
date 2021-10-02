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
  late OrdersService _service;

  @override
  Stream<List<Order>> get history => _controller.stream;

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
  Future<OrderDetail> fetchHistoryDetail(String id) async {
    try {
      final res = await _service.fetchRiderOrderDetail(id);
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
  Future<void> updateOrderPaymentStatus() async {
    try {

    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> updateOrderStatus() async {
    try {

    } catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    _controller.close();
  }
}
