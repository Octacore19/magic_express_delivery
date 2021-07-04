// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'registration_events.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class RegistrationEvents extends Equatable {
  const RegistrationEvents(this._type);

  factory RegistrationEvents.registerUser(
      {required String firstName,
      required String lastName,
      required String email,
      required String phoneNumber,
      required String password,
      required String confirmPassword}) = RegisterUser.create;

  final _RegistrationEvents _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _RegistrationEvents [_type]s defined.
  R when<R extends Object>({required R Function(RegisterUser) registerUser}) {
    switch (this._type) {
      case _RegistrationEvents.RegisterUser:
        return registerUser(this as RegisterUser);
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function(RegisterUser)? registerUser,
      required R Function(RegistrationEvents) orElse}) {
    switch (this._type) {
      case _RegistrationEvents.RegisterUser:
        if (registerUser == null) break;
        return registerUser(this as RegisterUser);
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial({void Function(RegisterUser)? registerUser}) {
    assert(() {
      if (registerUser == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _RegistrationEvents.RegisterUser:
        if (registerUser == null) break;
        return registerUser(this as RegisterUser);
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class RegisterUser extends RegistrationEvents {
  const RegisterUser(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.password,
      required this.confirmPassword})
      : super(_RegistrationEvents.RegisterUser);

  factory RegisterUser.create(
      {required String firstName,
      required String lastName,
      required String email,
      required String phoneNumber,
      required String password,
      required String confirmPassword}) = _RegisterUserImpl;

  final String firstName;

  final String lastName;

  final String email;

  final String phoneNumber;

  final String password;

  final String confirmPassword;

  /// Creates a copy of this RegisterUser but with the given fields
  /// replaced with the new values.
  RegisterUser copyWith(
      {String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String password,
      String confirmPassword});
}

@immutable
class _RegisterUserImpl extends RegisterUser {
  const _RegisterUserImpl(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.password,
      required this.confirmPassword})
      : super(
            firstName: firstName,
            lastName: lastName,
            email: email,
            phoneNumber: phoneNumber,
            password: password,
            confirmPassword: confirmPassword);

  @override
  final String firstName;

  @override
  final String lastName;

  @override
  final String email;

  @override
  final String phoneNumber;

  @override
  final String password;

  @override
  final String confirmPassword;

  @override
  _RegisterUserImpl copyWith(
          {Object firstName = superEnum,
          Object lastName = superEnum,
          Object email = superEnum,
          Object phoneNumber = superEnum,
          Object password = superEnum,
          Object confirmPassword = superEnum}) =>
      _RegisterUserImpl(
        firstName:
            firstName == superEnum ? this.firstName : firstName as String,
        lastName: lastName == superEnum ? this.lastName : lastName as String,
        email: email == superEnum ? this.email : email as String,
        phoneNumber:
            phoneNumber == superEnum ? this.phoneNumber : phoneNumber as String,
        password: password == superEnum ? this.password : password as String,
        confirmPassword: confirmPassword == superEnum
            ? this.confirmPassword
            : confirmPassword as String,
      );
  @override
  String toString() =>
      'RegisterUser(firstName: ${this.firstName}, lastName: ${this.lastName}, email: ${this.email}, phoneNumber: ${this.phoneNumber}, password: ${this.password}, confirmPassword: ${this.confirmPassword})';
  @override
  List<Object> get props =>
      [firstName, lastName, email, phoneNumber, password, confirmPassword];
}
