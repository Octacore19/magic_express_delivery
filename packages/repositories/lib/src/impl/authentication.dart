import 'dart:async';
import 'dart:convert';

import 'package:repositories/repositories.dart';
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
    required bool isRider,
  })  : _preference = preference,
        _isRider = isRider {
    _auth = AuthService(api: api);
  }

  final Preferences _preference;

  final _statusController = BehaviorSubject<AuthStatus>();
  late AuthService _auth;
  final bool _isRider;

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
    final aboutToExpire = await _tokenAboutToExpire();
    if (aboutToExpire) {
      logOut();
    } else {
      final userJson = await _preference.read<String>(key: userCacheKey) ?? '';
      if (userJson.isEmpty) {
        logOut();
      } else {
        _statusController.sink.add(AuthStatus.loggedIn);
      }
    }
  }

  @override
  Future<void> loginUser(String email, String password) async {
    try {
      final payload = {'email': email, 'password': password};
      final response = await _auth.loginUser(payload);
      if (!response.success) throw RequestFailureException(response.message);
      final data = BaseResponse.fromJson(response.data).data;
      if (data == null) throw AuthenticationException();
      final user = LoginResponse.fromJson(data).toUser;
      if (!user.isVerified) throw UnverifiedUserException();
      if ((user.role?.toLowerCase() == 'user' && _isRider) ||
          (user.role?.toLowerCase() == 'rider' && !_isRider))
        throw AuthenticationException('Account cannot log in here');
      final userString = user.toSerializedJson();
      await _preference.write<String>(key: userCacheKey, value: userString);
      _statusController.sink.add(AuthStatus.loggedIn);
      return;
    } on DioError catch (e) {
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
      if (!response.success) throw RequestFailureException(response.message);
      final res = BaseResponse.fromJson(response.data).data;
      if (res == null) throw AuthenticationException();
      return res['message'];
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<String> forgotPassword(String email) async {
    try {
      final data = {'email': email};
      final response = await _auth.forgotPassword(data);
      if (!response.success) throw RequestFailureException(response.message);
      final res = response.data['data']['status'];
      if (res == null) throw AuthenticationException();
      return res;
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<void> resendVerification(String email) async {
    try {
      final data = {'email': email};
      final response = await _auth.resendVerification(data);
      if (!response.success) throw RequestFailureException(response.message);
      final res = BaseResponse.fromJson(response.data).data;
      if (res == null) throw AuthenticationException();
      return res['message'];
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    _statusController.close();
  }

  @override
  void logOut() async {
    try {
      _preference.remove(key: userCacheKey);
      _preference.remove(key: ApiConstants.TOKEN);
      _preference.remove(key: ApiConstants.TIME_STAMP);
      _statusController.add(AuthStatus.loggedOut);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<bool> _tokenAboutToExpire() async {
    String timeStamp =
        await _preference.read<String>(key: ApiConstants.TIME_STAMP) ?? '';
    if (timeStamp.isNotEmpty) {
      final DateTime ex = DateTime.parse(timeStamp);
      final DateTime current = DateTime.now();
      return current.isAfter(ex) ||
          (current.isAfter(ex.subtract(Duration(hours: 1))) &&
              current.isBefore(ex));
    }
    return true;
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
          paystackKey: paystackKey ?? '',
          isVerified: u.isVerified ?? false
        );
      }
    }
    return User.empty;
  }
}
