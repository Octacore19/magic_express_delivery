import 'package:repositories/repositories.dart';
import 'package:repositories/src/contracts/contracts.dart';
import 'package:rxdart/rxdart.dart';
import 'package:services/services.dart';

class NotificationRepoImpl implements INotificationRepo {
  NotificationRepoImpl({required ApiProvider api}) {
    _service = NotificationService(api: api);
  }

  late NotificationService _service;

  final _controller = BehaviorSubject.seeded([]);

  @override
  Stream<List> get notifications => _controller.stream;

  @override
  Future<void> getAllNotifications() async {
    try {
      final res = await _service.getAllNotifications();
      if (!res.success) throw RequestFailureException(res.message);
      final data = BaseResponse.fromJson(res.data).data;
      if (data == null) throw NoDataException();
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> getReadNotifications() async {
    try {
      final res = await _service.getReadNotifications();
      if (!res.success) throw RequestFailureException(res.message);
      final data = BaseResponse.fromJson(res.data).data;
      if (data == null) throw NoDataException();
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> getUnreadNotifications() async {
    try {
      final res = await _service.getUnreadNotifications();
      if (!res.success) throw RequestFailureException(res.message);
      final data = BaseResponse.fromJson(res.data).data;
      if (data == null) throw NoDataException();
    } catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    _controller.close();
  }
}
