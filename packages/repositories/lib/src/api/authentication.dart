import 'package:repositories/src/contracts/contracts.dart';
import 'package:repositories/src/impl/impl.dart';
import 'package:repositories/src/models/user.dart';
import 'package:services/services.dart';

abstract class AuthException implements Exception {
  const AuthException([this.message = '']);

  final String? message;

  @override
  String toString() => "${runtimeType.toString()}: $message";
}

class RegistrationException extends AuthException {
  const RegistrationException([String? message = '']) : super(message);
}

class LoginException extends AuthException {
  const LoginException([String? message = '']) : super(message);
}

enum AuthStatus { unknown, loggedIn, registered, loggedOut }

class AuthRepo implements IAuthRepo {
  const AuthRepo._();

  static late IAuthRepo _authRepo;

  static AuthRepo getInstance({
    required Cache cache,
    required AuthService authService,
  }) {
    _authRepo = AuthRepoImpl(cache: cache, auth: authService);
    return AuthRepo._();
  }

  @override
  Stream<AuthStatus> get status => _authRepo.status;

  @override
  Future<User> get currentUser => _authRepo.currentUser;

  @override
  void dispose() => _authRepo.dispose();

  @override
  void logOut() => _authRepo.logOut();

  @override
  Future<void> loginUser(String email, String password) =>
      _authRepo.loginUser(email, password);

  @override
  Future<void> registerUser(
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String password,
    String confirmPassword,
  ) =>
      _authRepo.registerUser(
        firstName,
        lastName,
        email,
        phoneNumber,
        password,
        confirmPassword,
      );
}