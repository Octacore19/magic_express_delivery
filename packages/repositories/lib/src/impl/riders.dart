import 'package:repositories/repositories.dart';
import 'package:repositories/src/contracts/contracts.dart';
import 'package:repositories/src/models/history.dart';
import 'package:repositories/src/models/history_detail.dart';
import 'package:services/services.dart';

class RidersRepoImpl implements IRidersRepo {
  RidersRepoImpl({required ApiProvider api}) {
    _service = OrdersService(api: api);
  }

  final _controller = BehaviorSubject<List<History>>.seeded(List.empty());
  late OrdersService _service;

  @override
  Stream<List<History>> get history => _controller.stream;

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
      final history = list.map((e) => History.fromResponse(e)).toList();
      _controller.sink.add(history);
      return;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<HistoryDetail> fetchHistoryDetail(String id) async {
    try {
      final res = await _service.fetchRiderOrderDetail(id);
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
  Future<void> updateOrderPaymentStatus() {
    // TODO: implement updateOrderPaymentStatus
    throw UnimplementedError();
  }

  @override
  Future<void> updateOrderStatus() {
    // TODO: implement updateOrderStatus
    throw UnimplementedError();
  }

  @override
  void dispose() {
    _controller.close();
  }
}
