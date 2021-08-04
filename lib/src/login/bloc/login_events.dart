part of 'login_bloc.dart';

abstract class LoginEvents extends Equatable {
  const LoginEvents();

  @override
  List<Object> get props => [];
}

class LoginEmailChanged extends LoginEvents {
  const LoginEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class LoginEmailUnFocused extends LoginEvents {
  const LoginEmailUnFocused();
}

class LoginPasswordChanged extends LoginEvents {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginPasswordUnfocused extends LoginEvents {
  const LoginPasswordUnfocused();
}

class LoginPasswordVisibility extends LoginEvents {
  const LoginPasswordVisibility();
}

class LoginSubmitted extends LoginEvents {
  const LoginSubmitted();
}
