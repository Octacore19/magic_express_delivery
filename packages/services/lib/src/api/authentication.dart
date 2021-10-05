import 'package:services/services.dart';
import 'package:services/src/contracts/contracts.dart';
import 'package:services/src/impl/impl.dart';
import 'package:services/src/providers/providers.dart';

class AuthService implements IAuthenticationService {
  AuthService({required ApiProvider api}) {
    _auth = AuthImpl(api.mainInstance);
  }

  late IAuthenticationService _auth;

  @override
  Future<DioResponse> loginUser(Map<String, String> data) =>
      _auth.loginUser(data);

  @override
  Future<DioResponse> resendVerification(Map<String, String> data) =>
      _auth.resendVerification(data);

  @override
  Future<DioResponse> registerUser(Map<String, dynamic> data) =>
      _auth.registerUser(data);

  @override
  Future<DioResponse> forgotPassword(Map<String, dynamic> data) =>
      _auth.forgotPassword(data);

  @override
  Future<DioResponse> logoutUser() => _auth.logoutUser();
}
