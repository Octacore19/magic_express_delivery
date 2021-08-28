import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:repositories/src/api/api.dart';
import 'package:repositories/src/contracts/contracts.dart';
import 'package:repositories/src/models/models.dart';
import 'package:repositories/src/models/user.dart';
import 'package:rxdart/rxdart.dart';
import 'package:services/services.dart';

class AuthRepoImpl extends IAuthRepo {
  static const userCacheKey = '__user_cache_key__';

  AuthRepoImpl({
    required Preferences preference,
    required ApiProvider api,
  })  : _preference = preference {
    _auth = AuthService(api: api);
  }

  final Preferences _preference;

  final _statusController = BehaviorSubject<AuthStatus>();
  late AuthService _auth;

  @override
  Stream<AuthStatus> get status async* {
    yield AuthStatus.unknown;
    yield* _statusController.stream;
  }

  @override
  Future<User> get currentUser async {
    User? user;
    final userJson = await _preference.read<String>(key: userCacheKey) ?? '';
    if (userJson.isNotEmpty) {
      user = User.fromSerializedJson(jsonDecode(userJson));
    }
    return user ?? User.empty;
  }

  @override
  Future<void> onAppLaunch() async {
    final userJson = await _preference.read<String>(key: userCacheKey) ?? '';
    if (userJson.isEmpty) {
      _statusController.sink.add(AuthStatus.loggedOut);
    } else {
      _statusController.sink.add(AuthStatus.loggedIn);
    }
  }

  @override
  Future<void> loginUser(String email, String password) async {
    try {
      final data = {'email': email, 'password': password};
      final response = await _auth.loginUser(data);
      if (response.success) {
        final data = BaseResponse.fromJson(response.data).data;
        final user = LoginResponse.fromJson(data).toUser;
        final userString = user.toSerializedJson();
        _preference.write<String>(key: userCacheKey, value: userString);
        _statusController.sink.add(AuthStatus.loggedIn);
      } else {
        throw LoginException(response.message);
      }
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<String?> registerUser(
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
        return BaseResponse.fromJson(response.data).message;
      } else {
        throw RegistrationException(response.message);
      }
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    _statusController.close();
  }

  @override
  void logOut() {
    _preference.remove(key: userCacheKey);
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
