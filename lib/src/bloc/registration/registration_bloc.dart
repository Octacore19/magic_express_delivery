import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/bloc/bloc.dart';
import 'package:magic_express_delivery/src/domain/domain.dart';

class RegistrationBloc extends Bloc<RegistrationEvents, RegistrationState> {
  final IAuthRepo _authRepo;

  RegistrationBloc(this._authRepo)
      : super(RegistrationState.registrationInitial());

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvents event) async* {
    yield* event.when(registerUser: (d) => _mapRegisterUserToState(d));
  }

  Stream<RegistrationState> _mapRegisterUserToState(RegisterUser event) async* {
    yield RegistrationState.registrationLoading();

    try {
      final result = await _authRepo.registerUser(
        event.firstName,
        event.lastName,
        event.email,
        event.phoneNumber,
        event.password,
        event.confirmPassword,
      );
      yield result.fold(
        (l) => RegistrationState.registrationError(message: _mapFailureToMessage(l)),
        (r) => RegistrationState.registrationSuccess(message: r),
      );
    } on SocketException {
      yield RegistrationState.registrationError(
          message: 'Failed to connect to the Internet');
    } on HttpException {
      yield RegistrationState.registrationError(
          message: 'Failed to connect to the Internet');
    }
  }

  _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case AuthFailure:
        return (failure as AuthFailure).message;
      default:
        return 'Unexpected error';
    }
  }
}
