// ignore: import_of_legacy_library_into_null_safe
import 'package:super_enum/super_enum.dart';
import 'package:magic_express_delivery/src/index.dart';

part 'login_state.super.dart';

@superEnum
enum _LoginState {
  @object
  LoginInitial,
  @object
  LoginLoading,
  @UseClass(User)
  LoginSuccess,
  @Data(fields: [DataField<String>('message')])
  LoginError
}