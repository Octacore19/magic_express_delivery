// ignore: import_of_legacy_library_into_null_safe
import 'package:super_enum/super_enum.dart';

part 'registration_events.super.dart';

@superEnum
enum _RegistrationEvents {
  @Data(fields: [
    DataField<String>('firstName'),
    DataField<String>('lastName'),
    DataField<String>('email'),
    DataField<String>('phoneNumber'),
    DataField<String>('password'),
    DataField<String>('confrimPassword'),
  ])
  RegisterUser,
}
