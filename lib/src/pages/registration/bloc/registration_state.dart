part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  const RegistrationState({
    this.status = FormzStatus.pure,
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.email = const Email.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.passwordObscured = true,
    this.confirmPasswordObscured = true,
    this.message = '',
  });

  final FormzStatus status;
  final Name firstName;
  final Name lastName;
  final Email email;
  final PhoneNumber phoneNumber;
  final Password password;
  final ConfirmPassword confirmPassword;
  final bool passwordObscured;
  final bool confirmPasswordObscured;
  final String message;

  RegistrationState copyFrom({FormzStatus? status,
    Name? firstName,
    Name? lastName,
    Email? email,
    PhoneNumber? phoneNumber,
    Password? password,
    ConfirmPassword? confirmPassword,
    bool? passwordObscured,
    bool? confirmPasswordObscured,
    String? message}) =>
      RegistrationState(
        status: status ?? this.status,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        passwordObscured: passwordObscured ?? this.passwordObscured,
        confirmPasswordObscured:
        confirmPasswordObscured ?? this.confirmPasswordObscured,
        message: message ?? '',
      );

  @override
  List<Object?> get props =>
      [
        status,
        firstName,
        lastName,
        email,
        phoneNumber,
        password,
        confirmPassword,
        passwordObscured,
        confirmPasswordObscured,
        message
      ];
}
