import 'package:formz/formz.dart';

enum PhoneNumberValidatorError { empty }

class PhoneNumber extends FormzInput<String, PhoneNumberValidatorError> {
  const PhoneNumber.pure([String value = '']) : super.pure(value);

  const PhoneNumber.dirty([String value = '']) : super.dirty(value);

  @override
  PhoneNumberValidatorError? validator(String value) {
    return value.isEmpty ? PhoneNumberValidatorError.empty : null;
  }
}
