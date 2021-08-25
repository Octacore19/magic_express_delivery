import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:magic_express_delivery/src/login/login.dart';
import 'package:magic_express_delivery/src/registration/registration.dart';
import 'package:repositories/repositories.dart';

part 'registration_events.dart';

part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(RegistrationState());

  final AuthRepo _authRepo;

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    switch (event.action) {
      case RegistrationEvents.FirstNameChanged:
        yield _mapFirstNameChangedToState(event, state);
        break;
      case RegistrationEvents.LastNameChanged:
        yield _mapLastNameChangedToState(event, state);
        break;
      case RegistrationEvents.EmailChanged:
        yield _mapEmailChangedToState(event, state);
        break;
      case RegistrationEvents.PasswordChanged:
        yield _mapPasswordChangedToState(event, state);
        break;
      case RegistrationEvents.ConfirmPasswordChanged:
        yield _mapConfirmPasswordChangedToState(event, state);
        break;
      case RegistrationEvents.PhoneNumberChanged:
        yield _mapPhoneNumberChangedToState(event, state);
        break;
      case RegistrationEvents.FirstNameUnfocused:
        yield _mapFirstNameUnfocusedToState(state);
        break;
      case RegistrationEvents.LastNameUnfocused:
        yield _mapLastNameUnfocusedToState(state);
        break;
      case RegistrationEvents.EmailUnfocused:
        yield _mapEmailUnfocusedToState(state);
        break;
      case RegistrationEvents.PasswordUnfocused:
        yield _mapPasswordUnfocusedToState(state);
        break;
      case RegistrationEvents.ConfirmPasswordUnfocused:
        yield _mapConfirmPasswordUnfocusedToState(state);
        break;
      case RegistrationEvents.PhoneNumberUnfocused:
        yield _mapPhoneNumberUnfocusedToState(state);
        break;
      case RegistrationEvents.PasswordObscured:
        yield _mapPasswordObscuredToState(event, state);
        break;
      case RegistrationEvents.ConfirmPasswordObscured:
        yield _mapConfirmPasswordObscuredToState(event, state);
        break;
      case RegistrationEvents.CreateUser:
        yield* _mapCreateUserToState(state);
        break;
    }
  }

  RegistrationState _mapFirstNameChangedToState(
    RegistrationEvent event,
    RegistrationState state,
  ) {
    final firstName = FirstName.dirty(event.arguments);
    return state.copyFrom(
      firstName: firstName.valid ? firstName : FirstName.pure(event.arguments),
      status: Formz.validate([
        firstName,
        state.lastName,
        state.email,
        state.phoneNumber,
        state.password,
        state.confirmPassword,
      ]),
    );
  }

  RegistrationState _mapFirstNameUnfocusedToState(RegistrationState state) {
    final firstName = FirstName.dirty(state.firstName.value);
    return state.copyFrom(
      firstName: firstName,
      status: Formz.validate([
        firstName,
        state.lastName,
        state.email,
        state.phoneNumber,
        state.password,
        state.confirmPassword,
      ]),
    );
  }

  RegistrationState _mapLastNameChangedToState(
    RegistrationEvent event,
    RegistrationState state,
  ) {
    final lastName = LastName.dirty(event.arguments);
    return state.copyFrom(
      lastName: lastName.valid ? lastName : LastName.pure(event.arguments),
      status: Formz.validate([
        state.firstName,
        lastName,
        state.email,
        state.phoneNumber,
        state.password,
        state.confirmPassword,
      ]),
    );
  }

  RegistrationState _mapLastNameUnfocusedToState(RegistrationState state) {
    final lastName = LastName.dirty(state.lastName.value);
    return state.copyFrom(
      lastName: lastName,
      status: Formz.validate([
        state.firstName,
        lastName,
        state.email,
        state.phoneNumber,
        state.password,
        state.confirmPassword,
      ]),
    );
  }

  RegistrationState _mapEmailChangedToState(
    RegistrationEvent event,
    RegistrationState state,
  ) {
    final email = Email.dirty(event.arguments);
    return state.copyFrom(
      email: email.valid ? email : Email.pure(event.arguments),
      status: Formz.validate([
        state.firstName,
        state.lastName,
        email,
        state.phoneNumber,
        state.password,
        state.confirmPassword,
      ]),
    );
  }

  RegistrationState _mapEmailUnfocusedToState(RegistrationState state) {
    final email = Email.dirty(state.email.value);
    return state.copyFrom(
      email: email,
      status: Formz.validate([
        state.firstName,
        state.lastName,
        email,
        state.phoneNumber,
        state.password,
        state.confirmPassword,
      ]),
    );
  }

  RegistrationState _mapPhoneNumberChangedToState(
    RegistrationEvent event,
    RegistrationState state,
  ) {
    final phoneNumber = PhoneNumber.dirty(event.arguments);
    return state.copyFrom(
      phoneNumber:
          phoneNumber.valid ? phoneNumber : PhoneNumber.pure(event.arguments),
      status: Formz.validate([
        state.firstName,
        state.lastName,
        state.email,
        phoneNumber,
        state.password,
        state.confirmPassword,
      ]),
    );
  }

  RegistrationState _mapPhoneNumberUnfocusedToState(RegistrationState state) {
    final phoneNumber = PhoneNumber.dirty(state.phoneNumber.value);
    return state.copyFrom(
      phoneNumber: phoneNumber,
      status: Formz.validate([
        state.firstName,
        state.lastName,
        state.email,
        phoneNumber,
        state.password,
        state.confirmPassword,
      ]),
    );
  }

  RegistrationState _mapPasswordChangedToState(
    RegistrationEvent event,
    RegistrationState state,
  ) {
    final password = Password.dirty(event.arguments);
    return state.copyFrom(
      password: password.valid ? password : Password.pure(event.arguments),
      status: Formz.validate([
        state.firstName,
        state.lastName,
        state.email,
        state.phoneNumber,
        password,
        state.confirmPassword,
      ]),
    );
  }

  RegistrationState _mapPasswordUnfocusedToState(RegistrationState state) {
    final password = Password.dirty(state.password.value);
    return state.copyFrom(
      password: password,
      status: Formz.validate([
        state.firstName,
        state.lastName,
        state.email,
        state.phoneNumber,
        password,
        state.confirmPassword,
      ]),
    );
  }

  RegistrationState _mapConfirmPasswordChangedToState(
    RegistrationEvent event,
    RegistrationState state,
  ) {
    final confirmPassword = ConfirmPassword.dirty(
        password: state.password.value, value: event.arguments);
    return state.copyFrom(
      confirmPassword: confirmPassword.valid
          ? confirmPassword
          : ConfirmPassword.pure(
              password: state.password.value,
              value: event.arguments,
            ),
      status: Formz.validate([
        state.firstName,
        state.lastName,
        state.email,
        state.phoneNumber,
        state.password,
        confirmPassword,
      ]),
    );
  }

  RegistrationState _mapConfirmPasswordUnfocusedToState(
      RegistrationState state) {
    final confirmPassword = ConfirmPassword.dirty(
      password: state.password.value,
      value: state.confirmPassword.value,
    );
    return state.copyFrom(
      confirmPassword: confirmPassword,
      status: Formz.validate([
        state.firstName,
        state.lastName,
        state.email,
        state.phoneNumber,
        state.password,
        confirmPassword,
      ]),
    );
  }

  RegistrationState _mapPasswordObscuredToState(
    RegistrationEvent event,
    RegistrationState state,
  ) {
    final value = !state.passwordObscured;
    return state.copyFrom(passwordObscured: value);
  }

  RegistrationState _mapConfirmPasswordObscuredToState(
    RegistrationEvent event,
    RegistrationState state,
  ) {
    final value = !state.confirmPasswordObscured;
    return state.copyFrom(confirmPasswordObscured: value);
  }

  Stream<RegistrationState> _mapCreateUserToState(
      RegistrationState state) async* {
    final firstName = FirstName.dirty(state.firstName.value);
    final lastName = LastName.dirty(state.lastName.value);
    final email = Email.dirty(state.email.value);
    final phoneNumber = PhoneNumber.dirty(state.phoneNumber.value);
    final password = Password.dirty(state.password.value);
    final confirmPassword = ConfirmPassword.dirty(
      password: password.value,
      value: state.confirmPassword.value,
    );
    yield state.copyFrom(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
      confirmPassword: confirmPassword,
      status: Formz.validate([
        firstName,
        lastName,
        email,
        phoneNumber,
        password,
        confirmPassword,
      ]),
    );
    if (state.status.isValidated) {
      yield state.copyFrom(status: FormzStatus.submissionInProgress);
      try {
        final res = await _authRepo.registerUser(
          firstName.value,
          lastName.value,
          email.value,
          phoneNumber.value,
          password.value,
          confirmPassword.value,
        );
        yield state.copyFrom(status: FormzStatus.submissionSuccess, message: res);
      } on RegistrationException catch (e) {
        log("Exception caught: ${e.message}");
        yield state.copyFrom(
          status: FormzStatus.submissionFailure,
          message: e.message,
        );
      }
    }
  }
}
