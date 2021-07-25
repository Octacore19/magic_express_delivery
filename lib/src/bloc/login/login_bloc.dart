import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/index.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  final IAuthRepo _authRepo;

  LoginBloc(this._authRepo) : super(LoginState.loginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvents event) async* {
    yield* event.when(loginUser: (d) => _mapLoginUserToState(d));
  }

  Stream<LoginState> _mapLoginUserToState(LoginUser event) async* {
    yield LoginState.loginLoading();
    try {
      final result = await _authRepo.loginUser(event.email, event.password);
      yield result.fold(
        (l) => LoginState.loginError(message: _mapFailureToMessage(l)),
        (r) => LoginState.loginSuccess(r),
      );
    } on SocketException {
      yield LoginState.loginError(message: 'Failed to connect to the Internet');
    } on HttpException {
      yield LoginState.loginError(message: 'Failed to connect to the Internet');
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
