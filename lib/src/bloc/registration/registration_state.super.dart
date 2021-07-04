// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'registration_state.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class RegistrationState extends Equatable {
  const RegistrationState(this._type);

  factory RegistrationState.registrationInitial() = RegistrationInitial.create;

  factory RegistrationState.registrationLoading() = RegistrationLoading.create;

  factory RegistrationState.registrationSuccess({required String message}) =
      RegistrationSuccess.create;

  factory RegistrationState.registrationError({required String message}) =
      RegistrationError.create;

  final _RegistrationState _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _RegistrationState [_type]s defined.
  R when<R extends Object>(
      {required R Function() registrationInitial,
      required R Function() registrationLoading,
      required R Function(RegistrationSuccess) registrationSuccess,
      required R Function(RegistrationError) registrationError}) {
    switch (this._type) {
      case _RegistrationState.RegistrationInitial:
        return registrationInitial();
      case _RegistrationState.RegistrationLoading:
        return registrationLoading();
      case _RegistrationState.RegistrationSuccess:
        return registrationSuccess(this as RegistrationSuccess);
      case _RegistrationState.RegistrationError:
        return registrationError(this as RegistrationError);
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function()? registrationInitial,
      R Function()? registrationLoading,
      R Function(RegistrationSuccess)? registrationSuccess,
      R Function(RegistrationError)? registrationError,
      required R Function(RegistrationState) orElse}) {
    switch (this._type) {
      case _RegistrationState.RegistrationInitial:
        if (registrationInitial == null) break;
        return registrationInitial();
      case _RegistrationState.RegistrationLoading:
        if (registrationLoading == null) break;
        return registrationLoading();
      case _RegistrationState.RegistrationSuccess:
        if (registrationSuccess == null) break;
        return registrationSuccess(this as RegistrationSuccess);
      case _RegistrationState.RegistrationError:
        if (registrationError == null) break;
        return registrationError(this as RegistrationError);
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial(
      {void Function()? registrationInitial,
      void Function()? registrationLoading,
      void Function(RegistrationSuccess)? registrationSuccess,
      void Function(RegistrationError)? registrationError}) {
    assert(() {
      if (registrationInitial == null &&
          registrationLoading == null &&
          registrationSuccess == null &&
          registrationError == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _RegistrationState.RegistrationInitial:
        if (registrationInitial == null) break;
        return registrationInitial();
      case _RegistrationState.RegistrationLoading:
        if (registrationLoading == null) break;
        return registrationLoading();
      case _RegistrationState.RegistrationSuccess:
        if (registrationSuccess == null) break;
        return registrationSuccess(this as RegistrationSuccess);
      case _RegistrationState.RegistrationError:
        if (registrationError == null) break;
        return registrationError(this as RegistrationError);
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class RegistrationInitial extends RegistrationState {
  const RegistrationInitial() : super(_RegistrationState.RegistrationInitial);

  factory RegistrationInitial.create() = _RegistrationInitialImpl;
}

@immutable
class _RegistrationInitialImpl extends RegistrationInitial {
  const _RegistrationInitialImpl() : super();

  @override
  String toString() => 'RegistrationInitial()';
}

@immutable
abstract class RegistrationLoading extends RegistrationState {
  const RegistrationLoading() : super(_RegistrationState.RegistrationLoading);

  factory RegistrationLoading.create() = _RegistrationLoadingImpl;
}

@immutable
class _RegistrationLoadingImpl extends RegistrationLoading {
  const _RegistrationLoadingImpl() : super();

  @override
  String toString() => 'RegistrationLoading()';
}

@immutable
abstract class RegistrationSuccess extends RegistrationState {
  const RegistrationSuccess({required this.message})
      : super(_RegistrationState.RegistrationSuccess);

  factory RegistrationSuccess.create({required String message}) =
      _RegistrationSuccessImpl;

  final String message;

  /// Creates a copy of this RegistrationSuccess but with the given fields
  /// replaced with the new values.
  RegistrationSuccess copyWith({String message});
}

@immutable
class _RegistrationSuccessImpl extends RegistrationSuccess {
  const _RegistrationSuccessImpl({required this.message})
      : super(message: message);

  @override
  final String message;

  @override
  _RegistrationSuccessImpl copyWith({Object message = superEnum}) =>
      _RegistrationSuccessImpl(
        message: message == superEnum ? this.message : message as String,
      );
  @override
  String toString() => 'RegistrationSuccess(message: ${this.message})';
  @override
  List<Object> get props => [message];
}

@immutable
abstract class RegistrationError extends RegistrationState {
  const RegistrationError({required this.message})
      : super(_RegistrationState.RegistrationError);

  factory RegistrationError.create({required String message}) =
      _RegistrationErrorImpl;

  final String message;

  /// Creates a copy of this RegistrationError but with the given fields
  /// replaced with the new values.
  RegistrationError copyWith({String message});
}

@immutable
class _RegistrationErrorImpl extends RegistrationError {
  const _RegistrationErrorImpl({required this.message})
      : super(message: message);

  @override
  final String message;

  @override
  _RegistrationErrorImpl copyWith({Object message = superEnum}) =>
      _RegistrationErrorImpl(
        message: message == superEnum ? this.message : message as String,
      );
  @override
  String toString() => 'RegistrationError(message: ${this.message})';
  @override
  List<Object> get props => [message];
}
