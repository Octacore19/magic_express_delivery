import 'dart:async';

import 'package:repositories/src/api/api.dart';
import 'package:repositories/src/contracts/contracts.dart';
import 'package:repositories/src/models/models.dart';
import 'package:repositories/src/models/user.dart';
import 'package:services/services.dart';

class AuthRepoImpl extends IAuthRepo {
  static const userCacheKey = '__user_cache_key__';

  AuthRepoImpl({
    required Cache cache,
    required AuthService auth,
  })  : _cache = cache,
        _auth = auth;

  final Cache _cache;
  final AuthService _auth;

  final _statusController = StreamController<AuthStatus>();

  @override
  Stream<AuthStatus> get status async* {
    yield AuthStatus.loggedOut;
    yield* _statusController.stream;
  }

  @override
  Future<User> get currentUser async {
    final user = await _cache.read<User>(key: userCacheKey);
    return user ?? User.empty;
  }

  @override
  Future<void> loginUser(String email, String password) async {
    try {
      final data = {
        'email': email,
        'password': password,
      };
      final response = await _auth.loginUser(data);
      if (response.success) {
        final data = LoginResponse.fromJson(response.data);
        _cache.write(key: userCacheKey, value: data.toUser);
        _statusController.add(AuthStatus.loggedIn);
      }
      throw LoginException(response.message);
    } on Exception {
      throw LoginException();
    }
  }

  @override
  Future<void> registerUser(
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String password,
    String confirmPassword,
  ) async {
    try {
      final data = {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'role_id': 3,
        'phone_number': phoneNumber,
        'password': password,
        'password_confirmation': confirmPassword,
      };
      final response = await _auth.registerUser(data);
      if (response.success) {
        _statusController.add(AuthStatus.registered);
      }
      throw LoginException(response.message);
    } on Exception {
      throw LoginException();
    }
  }

  @override
  void dispose() {
    _statusController.close();
  }

  @override
  void logOut() {
    _statusController.add(AuthStatus.loggedOut);
  }
}

extension on LoginResponse {
  User get toUser {
    if (user != null) {
      final u = user!;
      if (u.email != null && u.phoneNumber != null) {
        return User(
          email: u.email ?? '',
          phoneNumber: u.phoneNumber ?? '',
          firstName: u.firstName,
          lastName: u.lastName,
          role: u.role,
        );
      }
    }
    return User.empty;
  }
}
