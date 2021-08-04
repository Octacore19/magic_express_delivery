import 'package:services/services.dart';
import 'package:services/src/contracts/contracts.dart';
import 'package:services/src/impl/impl.dart';
import 'package:services/src/local/local.dart';
import 'package:services/src/providers/providers.dart';

class AuthService implements IAuthenticationService {
  static late IAuthenticationService _auth;

  const AuthService._();

  static AuthService getInstance(ICache cache) {
    final api = ApiProvider(cache: cache);
    _auth = AuthImpl(api.instance);
    return AuthService._();
  }

  @override
  Future<BaseResponse> loginUser(Map<String, String> data) => _auth.loginUser(data);

  @override
  Future<BaseResponse> registerUser(Map<String, dynamic> data) => _auth.registerUser(data);
}
