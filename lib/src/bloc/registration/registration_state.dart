// ignore: import_of_legacy_library_into_null_safe
import 'package:super_enum/super_enum.dart';

part 'registration_state.super.dart';

@superEnum
enum _RegistrationState {
  @object
  RegistrationInitial,
  @object
  RegistrationLoading,
  @Data(fields: [DataField<String>('message')])
  RegistrationSuccess,
  @Data(fields: [DataField<String>('message')])
  RegistrationError
}