import 'package:dio/dio.dart';
import 'package:magic_express_delivery/src/index.dart';

class AuthService implements IAuthService {
  final ApiProvider _provider;

  AuthService(this._provider);

  @override
  Future<BaseResponse> loginUser(Map<String, String> data) async {
    final baseResponse = await _provider.dioInstance.post(
      ApiEndpoints.LOGIN_USER,
      data: FormData.fromMap(data),
      options: Options(
        headers: {"no_token": true},
      ),
    );
    return BaseResponse.fromJson(baseResponse.data);
  }

  @override
  Future<BaseResponse> registerUser(Map<String, dynamic> data) async {
    final baseResponse = await _provider.dioInstance.post(
      ApiEndpoints.REGISTER_USER,
      data: FormData.fromMap(data),
      options: Options(
        headers: {"no_token": true},
      ),
    );
    return BaseResponse.fromJson(baseResponse.data);
  }
}
