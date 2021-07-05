class BaseResponse {
  final dynamic data;
  final bool success;
  final int? code;
  final String? message;

  BaseResponse({
    required this.data,
    required this.success,
    this.code,
    this.message,
  });

  BaseResponse.fromJson(Map<String, dynamic> json)
      : data = json['data'],
        success = json['success'],
        code = json['code'],
        message = json['message'];

  @override
  String toString() {
    return '"data":$data, '
        '"success":$success, '
        '"code":$code, '
        '"message":$message. ';
  }
}
