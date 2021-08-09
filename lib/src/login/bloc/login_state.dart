part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.passwordObscured = true,
    this.message = '',
  });

  final FormzStatus status;
  final Email email;
  final Password password;
  final bool passwordObscured;
  final String message;

  LoginState copyWith({
    FormzStatus? status,
    Email? email,
    Password? password,
    bool? passwordVisible,
    String? message,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordObscured: passwordVisible ?? this.passwordObscured,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status, email, password, passwordObscured, message];
}