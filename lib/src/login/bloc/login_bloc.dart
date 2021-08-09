import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:magic_express_delivery/src/login/login.dart';
import 'package:repositories/repositories.dart';

part 'login_events.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  LoginBloc({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(LoginState());

  final AuthRepo _authRepo;

  @override
  Stream<LoginState> mapEventToState(LoginEvents event) async* {
    if (event is LoginEmailChanged)
      yield _mapEmailChangedToState(event, state);
    else if (event is LoginPasswordChanged)
      yield _mapPasswordChangedToState(event, state);
    else if (event is LoginEmailUnFocused)
      yield _mapEmailUnfocusedToState(event, state);
    else if (event is LoginPasswordUnfocused)
      yield _mapPasswordUnfocusedToState(event, state);
    else if (event is LoginPasswordVisibility)
      yield _mapPasswordVisibilityToState(event, state);
    else if (event is LoginSubmitted)
      yield* _mapLoginSubmittedToState(event, state);
  }

  LoginState _mapEmailChangedToState(
    LoginEmailChanged event,
    LoginState state,
  ) {
    final email = Email.dirty(event.email);
    return state.copyWith(
      email: email.valid ? email : Email.pure(event.email),
      status: Formz.validate([state.password, email]),
    );
  }

  LoginState _mapEmailUnfocusedToState(
    LoginEmailUnFocused event,
    LoginState state,
  ) {
    final email = Email.dirty(state.email.value);
    return state.copyWith(
      email: email,
      status: Formz.validate([state.password, email]),
    );
  }

  LoginState _mapPasswordChangedToState(
    LoginPasswordChanged event,
    LoginState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password.valid ? password : Password.pure(event.password),
      status: Formz.validate([password, state.email]),
    );
  }

  LoginState _mapPasswordUnfocusedToState(
    LoginPasswordUnfocused event,
    LoginState state,
  ) {
    final password = Password.dirty(state.password.value);
    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.email]),
    );
  }

  LoginState _mapPasswordVisibilityToState(
    LoginPasswordVisibility event,
    LoginState state,
  ) {
    final visibility = !state.passwordObscured;
    return state.copyWith(passwordVisible: visibility);
  }

  Stream<LoginState> _mapLoginSubmittedToState(
    LoginSubmitted event,
    LoginState state,
  ) async* {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    yield state.copyWith(
      email: email,
      password: password,
      status: Formz.validate([email, password]),
    );
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await _authRepo.loginUser(state.email.value, state.password.value);
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on LoginException catch (e) {
        log("Exception caught: ${e.message}");
        yield state.copyWith(
          status: FormzStatus.submissionFailure,
          message: e.message,
        );
      }
    }
  }
}
