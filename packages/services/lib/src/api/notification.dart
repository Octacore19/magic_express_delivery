import 'package:services/services.dart';
import 'package:services/src/contracts/contracts.dart';
import 'package:services/src/impl/notification.dart';
import 'package:services/src/models/dio_response.dart';

class NotificationService implements INotificationService {
  NotificationService({required ApiProvider api})
      : _service = NotificationServiceImpl(api.mainInstance);
  final NotificationServiceImpl _service;

  @override
  Future<DioResponse> getAllNotifications() => _service.getAllNotifications();

  @override
  Future<DioResponse> getReadNotifications() => _service.getReadNotifications();

  @override
  Future<DioResponse> getUnreadNotifications() => _service.getUnreadNotifications();
}
