// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'login_events.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class LoginEvents extends Equatable {
  const LoginEvents(this._type);

  factory LoginEvents.loginUser(
      {required String email, required String password}) = LoginUser.create;

  final _LoginEvents _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _LoginEvents [_type]s defined.
  R when<R extends Object>({required R Function(LoginUser) loginUser}) {
    assert(() {
      // ignore: unnecessary_null_comparison
      if (loginUser == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _LoginEvents.LoginUser:
        return loginUser(this as LoginUser);
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function(LoginUser)? loginUser,
      required R Function(LoginEvents) orElse}) {
    assert(() {
      // ignore: unnecessary_null_comparison
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _LoginEvents.LoginUser:
        if (loginUser == null) break;
        return loginUser(this as LoginUser);
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial({void Function(LoginUser)? loginUser}) {
    assert(() {
      if (loginUser == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _LoginEvents.LoginUser:
        if (loginUser == null) break;
        return loginUser(this as LoginUser);
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class LoginUser extends LoginEvents {
  const LoginUser({required this.email, required this.password})
      : super(_LoginEvents.LoginUser);

  factory LoginUser.create(
      {required String email, required String password}) = _LoginUserImpl;

  final String email;

  final String password;

  /// Creates a copy of this LoginUser but with the given fields
  /// replaced with the new values.
  LoginUser copyWith({String email, String password});
}

@immutable
class _LoginUserImpl extends LoginUser {
  const _LoginUserImpl({required this.email, required this.password})
      : super(email: email, password: password);

  @override
  final String email;

  @override
  final String password;

  @override
  _LoginUserImpl copyWith(
          {Object email = superEnum, Object password = superEnum}) =>
      _LoginUserImpl(
        email: email == superEnum ? this.email : email as String,
        password: password == superEnum ? this.password : password as String,
      );
  @override
  String toString() =>
      'LoginUser(email: ${this.email}, password: ${this.password})';
  @override
  List<Object> get props => [email, password];
}
