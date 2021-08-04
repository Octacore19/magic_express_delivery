import 'package:formz/formz.dart';

enum PasswordValidationError { empty, invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure([String value = '']): super.pure(value);

  const Password.dirty([String value = '']): super.dirty(value);

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty)
      return PasswordValidationError.empty;
    else if (value.isNotEmpty && value.length < 5)
      return PasswordValidationError.invalid;
    else
      return null;
  }
}
