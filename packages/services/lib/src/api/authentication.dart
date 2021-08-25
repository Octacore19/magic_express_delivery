import 'package:services/services.dart';
import 'package:services/src/contracts/contracts.dart';
import 'package:services/src/impl/impl.dart';
import 'package:services/src/providers/providers.dart';

class AuthService implements IAuthenticationService {
  AuthService({required ApiProvider api}) {
    _auth = AuthImpl(api.instance);
  }

  late IAuthenticationService _auth;

  @override
  Future<DioResponse> loginUser(Map<String, String> data) =>
      _auth.loginUser(data);

  @override
  Future<DioResponse> registerUser(Map<String, dynamic> data) =>
      _auth.registerUser(data);
}
