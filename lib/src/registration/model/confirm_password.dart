import 'package:formz/formz.dart';

enum ConfirmPasswordValidator { no_match, empty }

class ConfirmPassword extends FormzInput<String, ConfirmPasswordValidator> {
  const ConfirmPassword.pure({this.password = '', String value = ''})
      : super.pure(value);

  const ConfirmPassword.dirty({this.password = '', String value = ''})
      : super.dirty(value);

  final String password;

  @override
  ConfirmPasswordValidator? validator(String value) {
    if (value.isEmpty) {
      return ConfirmPasswordValidator.empty;
    } else if (password != value) {
      return ConfirmPasswordValidator.no_match;
    } else
      return null;
  }
}
