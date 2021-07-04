// ignore: import_of_legacy_library_into_null_safe
import 'package:super_enum/super_enum.dart';

part 'login_events.super.dart';

@superEnum
enum _LoginEvents {
  @Data(fields: [DataField<String>('email'), DataField<String>('password')])
  LoginUser,

  // ForgotPassword,
  // ResetPassword
}