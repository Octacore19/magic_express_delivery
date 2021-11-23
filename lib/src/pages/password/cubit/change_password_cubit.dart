import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:repositories/repositories.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState._({
    required this.status,
    required this.oldPassword,
    required this.newPassword,
    required this.confirmNew,
  });

  factory ChangePasswordState.init() {
    return ChangePasswordState._(
      status: FormzStatus.pure,
      oldPassword: Password.pure(),
      newPassword: Password.pure(),
      confirmNew: ConfirmPassword.pure(),
    );
  }

  final FormzStatus status;
  final Password oldPassword;
  final Password newPassword;
  final ConfirmPassword confirmNew;

  ChangePasswordState copyWith({
    FormzStatus? status,
    Password? oldPassword,
    Password? newPassword,
    ConfirmPassword? confirmNew,
  }) {
    return ChangePasswordState._(
      status: status ?? this.status,
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmNew: confirmNew ?? this.confirmNew,
    );
  }

  @override
  List<Object?> get props => [status, oldPassword, newPassword, confirmNew];
}

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({
    required ErrorHandler errorHandler,
    required MiscRepo miscRepo,
  }) : super(ChangePasswordState.init());

  void onOldPasswordChanged(String value) {
    final password = Password.dirty(value);
    final s = state.copyWith(
      oldPassword: password.valid ? password : Password.pure(value),
      status: Formz.validate([password, state.oldPassword]),
    );
    emit(s);
  }

  void onNewPasswordChanged(String value) {
    final password = Password.dirty(value);
    final s = state.copyWith(
      newPassword: password.valid ? password : Password.pure(value),
      status: Formz.validate([password, state.newPassword]),
    );
    emit(s);
  }

  void onConfirmPasswordChanged(String value) {
    final confirmPassword =
        ConfirmPassword.dirty(password: state.newPassword.value, value: value);
    final s = state.copyWith(
        confirmNew: confirmPassword.valid
            ? confirmPassword
            : ConfirmPassword.pure(
                password: state.newPassword.value,
                value: value,
              ));
    emit(s);
  }
}
