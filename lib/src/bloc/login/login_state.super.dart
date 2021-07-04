// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'login_state.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class LoginState extends Equatable {
  const LoginState(this._type);

  factory LoginState.loginInitial() = LoginInitial.create;

  factory LoginState.loginLoading() = LoginLoading.create;

  factory LoginState.loginSuccess(User user) = UserWrapper;

  factory LoginState.loginError({required String message}) = LoginError.create;

  final _LoginState _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _LoginState [_type]s defined.
  R when<R extends Object>(
      {required R Function() loginInitial,
      required R Function() loginLoading,
      required R Function(User) loginSuccess,
      required R Function(LoginError) loginError}) {
    switch (this._type) {
      case _LoginState.LoginInitial:
        return loginInitial();
      case _LoginState.LoginLoading:
        return loginLoading();
      case _LoginState.LoginSuccess:
        return loginSuccess((this as UserWrapper).user);
      case _LoginState.LoginError:
        return loginError(this as LoginError);
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function()? loginInitial,
      R Function()? loginLoading,
      R Function(User)? loginSuccess,
      R Function(LoginError)? loginError,
      required R Function(LoginState) orElse}) {
    switch (this._type) {
      case _LoginState.LoginInitial:
        if (loginInitial == null) break;
        return loginInitial();
      case _LoginState.LoginLoading:
        if (loginLoading == null) break;
        return loginLoading();
      case _LoginState.LoginSuccess:
        if (loginSuccess == null) break;
        return loginSuccess((this as UserWrapper).user);
      case _LoginState.LoginError:
        if (loginError == null) break;
        return loginError(this as LoginError);
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial(
      {void Function()? loginInitial,
      void Function()? loginLoading,
      void Function(User)? loginSuccess,
      void Function(LoginError)? loginError}) {
    assert(() {
      if (loginInitial == null &&
          loginLoading == null &&
          loginSuccess == null &&
          loginError == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _LoginState.LoginInitial:
        if (loginInitial == null) break;
        return loginInitial();
      case _LoginState.LoginLoading:
        if (loginLoading == null) break;
        return loginLoading();
      case _LoginState.LoginSuccess:
        if (loginSuccess == null) break;
        return loginSuccess((this as UserWrapper).user);
      case _LoginState.LoginError:
        if (loginError == null) break;
        return loginError(this as LoginError);
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class LoginInitial extends LoginState {
  const LoginInitial() : super(_LoginState.LoginInitial);

  factory LoginInitial.create() = _LoginInitialImpl;
}

@immutable
class _LoginInitialImpl extends LoginInitial {
  const _LoginInitialImpl() : super();

  @override
  String toString() => 'LoginInitial()';
}

@immutable
abstract class LoginLoading extends LoginState {
  const LoginLoading() : super(_LoginState.LoginLoading);

  factory LoginLoading.create() = _LoginLoadingImpl;
}

@immutable
class _LoginLoadingImpl extends LoginLoading {
  const _LoginLoadingImpl() : super();

  @override
  String toString() => 'LoginLoading()';
}

@immutable
class UserWrapper extends LoginState {
  const UserWrapper(this.user) : super(_LoginState.LoginSuccess);

  final User user;

  @override
  String toString() => 'UserWrapper($user)';
  @override
  List<Object> get props => [user];
}

@immutable
abstract class LoginError extends LoginState {
  const LoginError({required this.message}) : super(_LoginState.LoginError);

  factory LoginError.create({required String message}) = _LoginErrorImpl;

  final String message;

  /// Creates a copy of this LoginError but with the given fields
  /// replaced with the new values.
  LoginError copyWith({String message});
}

@immutable
class _LoginErrorImpl extends LoginError {
  const _LoginErrorImpl({required this.message}) : super(message: message);

  @override
  final String message;

  @override
  _LoginErrorImpl copyWith({Object message = superEnum}) => _LoginErrorImpl(
        message: message == superEnum ? this.message : message as String,
      );
  @override
  String toString() => 'LoginError(message: ${this.message})';
  @override
  List<Object> get props => [message];
}
