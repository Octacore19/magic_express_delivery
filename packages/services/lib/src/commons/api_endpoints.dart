class ApiEndpoints {
  const ApiEndpoints._();

  //AUTHENTICATION
  static const LOGIN_USER = '/auth/login';
  static const REGISTER_USER = '/auth/register';
  static const FORGOT_PASSWORD = '/auth/password/forgot';
  static const RESEND_VERIFY = '/auth/resend-verification';
  static const LOG_OUT = '/logout';

  //ORDERS
  static const CREATE_ORDER = '/user/place-order';
  static const USER_ORDERS = '/user/orders';
  static const USER_ORDER_DETAIL = '/user/order';
  static const RIDER_ORDERS = '/rider/orders';
  static const RIDER_ORDER_DETAIL = '/rider/order';
  static const RIDER_AVAILABILITY = '/rider/availability';

  //GOOGLE PLACES
  static const SEARCH_PLACE = '/place/autocomplete/json';
  static const DETAIL_PLACE = '/place/details/json';
  static const DISTANCE_MATRIX = '/distancematrix/json';

  //NOTIFICATIONS
  static const ALL_NOTIFICATIONS = '/notifications/all';
  static const UNREAD_NOTIFICATIONS = '/notifications/unread';
  static const READ_NOTIFICATIONS = '/notifications/read';
  static const MARK_AS_READ = '/notifications';

  //SETTINGS
  static const UPDATE_LOCATION = '/settings/update-location';
  static const UPDATE_USER_PASSWORD = '/settings/update-password';
  static const DEVICE_TOKEN = '/settings/fcm-token';
  static const USER_LOCATION = '/settings/update-location';

  //MISCELLANEOUS
  static const CHARGES = '/charges';
  static const VERIFY_PAYMENT = '/verify_transaction';
  static const TRACK_ORDER = '/track/order';
}
