import 'package:formz/formz.dart';

enum NameValidationError { empty }

abstract class Name extends FormzInput<String, NameValidationError> {
  const Name.pure([String value = '']) : super.pure(value);

  const Name.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError? validator(String value) {
    return value.isEmpty ? NameValidationError.empty : null;
  }
}

class FirstName extends Name {
  const FirstName.pure([String value = '']) : super.pure(value);

  const FirstName.dirty([String value = '']) : super.dirty(value);
}

class LastName extends Name {
  const LastName.pure([String value = '']) : super.pure(value);

  const LastName.dirty([String value = '']) : super.dirty(value);
}
