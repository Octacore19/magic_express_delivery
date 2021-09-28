import 'package:services/services.dart';

abstract class INotificationService {
  Future<DioResponse> getAllNotifications();

  Future<DioResponse> getUnreadNotifications();

  Future<DioResponse> getReadNotifications();
}
