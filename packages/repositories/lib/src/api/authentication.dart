import 'package:repositories/src/contracts/contracts.dart';
import 'package:repositories/src/impl/impl.dart';
import 'package:repositories/src/models/user.dart';
import 'package:services/services.dart';

enum AuthStatus { unknown, loggedIn, loggedOut }

class AuthRepo implements IAuthRepo {
  AuthRepo({
    required Preferences preference,
    required ApiProvider api,
    required bool isRider,
  }) {
    _authRepo = AuthRepoImpl(
      preference: preference,
      api: api,
      isRider: isRider,
    );
  }

  late IAuthRepo _authRepo;

  @override
  Stream<AuthStatus> get status => _authRepo.status;

  @override
  Future<User> get currentUser => _authRepo.currentUser;

  @override
  Future<void> onAppLaunch() => _authRepo.onAppLaunch();

  @override
  Future<void> resendVerification(String email) =>
      _authRepo.resendVerification(email);

  @override
  void dispose() => _authRepo.dispose();

  @override
  void logOut() => _authRepo.logOut();

  @override
  Future<void> loginUser(String email, String password) =>
      _authRepo.loginUser(email, password);

  @override
  Future<String?> registerUser(
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

  @override
  Future<String> forgotPassword(String email) =>
      _authRepo.forgotPassword(email);
}
