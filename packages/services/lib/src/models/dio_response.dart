class DioResponse {
  dynamic data;
  final bool success;
  final String message;
  final int statusCode;

  DioResponse.fromJson(Map<String, dynamic> json)
      : data = json['data'],
        success = json['success'],
        statusCode = json['code'],
        message = json['message'];

  @override
  String toString() {
    return 'DioResponse(data: $data, '
        'success: $success, '
        'statusCode: $statusCode, '
        'message: $message)';
  }
}
