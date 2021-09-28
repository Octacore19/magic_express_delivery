import 'package:repositories/src/contracts/contracts.dart';
import 'package:repositories/src/impl/impl.dart';
import 'package:services/services.dart';

class NotificationRepo implements INotificationRepo {
  NotificationRepo({required ApiProvider api}) {
    _repo = NotificationRepoImpl(api: api);
  }

  late INotificationRepo _repo;

  @override
  void dispose() => _repo.dispose();

  @override
  Future<void> getAllNotifications() => _repo.getAllNotifications();

  @override
  Future<void> getReadNotifications() => _repo.getReadNotifications();

  @override
  Future<void> getUnreadNotifications() => _repo.getUnreadNotifications();

  @override
  Stream<List> get notifications => _repo.notifications;
}
