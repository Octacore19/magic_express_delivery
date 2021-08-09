part of 'registration_bloc.dart';

enum RegistrationEvents {
  FirstNameChanged,
  FirstNameUnfocused,
  LastNameChanged,
  LastNameUnfocused,
  EmailChanged,
  EmailUnfocused,
  PasswordChanged,
  PasswordUnfocused,
  ConfirmPasswordChanged,
  ConfirmPasswordUnfocused,
  PhoneNumberChanged,
  PhoneNumberUnfocused,
  PasswordObscured,
  ConfirmPasswordObscured,
  CreateUser,
}

class RegistrationEvent extends Equatable {
  RegistrationEvent({
    required this.action,
    this.arguments,
  });

  final RegistrationEvents action;
  final dynamic arguments;

  @override
  List<Object?> get props => [action, arguments];
}
