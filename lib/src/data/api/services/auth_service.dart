import 'package:dio/dio.dart';
import 'package:magic_express_delivery/src/index.dart';

class AuthService implements IAuthService {
  final ApiProvider _provider;

  AuthService(this._provider);

  @override
  Future<BaseResponse> loginuser(String email, String password) async {
    final baseResponse = await _provider.dioInstance.post(
      ApiEndpoints.LOGIN_USER,
      data: FormData.fromMap({
        'email': email,
        'password': password,
      }),
      options: Options(
        headers: {"no_token": true},
      ),
    );
    return BaseResponse.fromJson(baseResponse.data);
  }

  @override
  Future registerUser(String firstName, String lastName, String email,
      String phoneNumber, String password, String confirmPassword) {
    throw UnimplementedError();
  }
}
