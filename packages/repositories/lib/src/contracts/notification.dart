abstract class INotificationRepo {
  Stream<List> get notifications;

  Future<void> getAllNotifications();

  Future<void> getUnreadNotifications();

  Future<void> getReadNotifications();

  void dispose();
}