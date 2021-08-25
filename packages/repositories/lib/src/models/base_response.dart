class BaseResponse {
  BaseResponse.fromJson(Map<String, dynamic> json)
      : data = json['data'],
        message = json['message'];

  final dynamic data;
  final String? message;

  @override
  String toString() {
    return '$runtimeType(data: $data, message: $message)';
  }
}
