import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:repositories/repositories.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState._({
    required this.loading,
    required this.oldPasswordObscured,
    required this.newPasswordObscured,
    required this.confirmPasswordObscured,
    required this.status,
    required this.oldPassword,
    required this.newPassword,
    required this.confirmNew,
  });

  factory ChangePasswordState.init() {
    return ChangePasswordState._(
      loading: false,
      confirmPasswordObscured: true,
      newPasswordObscured: true,
      oldPasswordObscured: true,
      status: FormzStatus.pure,
      oldPassword: Password.pure(),
      newPassword: Password.pure(),
      confirmNew: ConfirmPassword.pure(),
    );
  }

  final bool loading;
  final bool oldPasswordObscured;
  final bool newPasswordObscured;
  final bool confirmPasswordObscured;
  final FormzStatus status;
  final Password oldPassword;
  final Password newPassword;
  final ConfirmPassword confirmNew;

  ChangePasswordState copyWith({
    bool? loading,
    bool? oldPasswordObscured,
    bool? newPasswordObscured,
    bool? confirmPasswordObscured,
    FormzStatus? status,
    Password? oldPassword,
    Password? newPassword,
    ConfirmPassword? confirmNew,
  }) {
    return ChangePasswordState._(
      loading: loading ?? this.loading,
      oldPasswordObscured: oldPasswordObscured ?? this.oldPasswordObscured,
      newPasswordObscured: newPasswordObscured ?? this.newPasswordObscured,
      confirmPasswordObscured:
          confirmPasswordObscured ?? this.confirmPasswordObscured,
      status: status ?? this.status,
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmNew: confirmNew ?? this.confirmNew,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        oldPasswordObscured,
        newPasswordObscured,
        confirmPasswordObscured,
        status,
        oldPassword,
        newPassword,
        confirmNew
      ];
}

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({
    required ErrorHandler errorHandler,
    required MiscRepo miscRepo,
  })  : _repo = miscRepo,
        _handler = errorHandler,
        super(ChangePasswordState.init());

  final ErrorHandler _handler;
  final MiscRepo _repo;

  void onOldPasswordChanged(String value) {
    final password = Password.dirty(value);
    final s = state.copyWith(
      oldPassword: password.valid ? password : Password.pure(value),
      status: Formz.validate([password, state.newPassword, state.confirmNew]),
    );
    emit(s);
  }

  void onNewPasswordChanged(String value) {
    final password = Password.dirty(value);
    final s = state.copyWith(
      newPassword: password.valid ? password : Password.pure(value),
      status: Formz.validate([password, state.oldPassword, state.confirmNew]),
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
            ),
      status: Formz.validate([
        state.oldPassword,
        state.newPassword,
        confirmPassword,
      ]),
    );
    emit(s);
  }

  void onOldPasswordUnfocused() {
    final password = Password.dirty(state.oldPassword.value);
    final s = state.copyWith(
      oldPassword: password,
      status: Formz.validate([
        password,
        state.newPassword,
        state.confirmNew,
      ]),
    );
    emit(s);
  }

  void onNewPasswordUnfocused() {
    final password = Password.dirty(state.newPassword.value);
    final s = state.copyWith(
      newPassword: password,
      status: Formz.validate([
        state.oldPassword,
        password,
        state.confirmNew,
      ]),
    );
    emit(s);
  }

  void onConfirmPasswordUnfocused() {
    final confirmPassword = ConfirmPassword.dirty(
      password: state.newPassword.value,
      value: state.confirmNew.value,
    );
    final s = state.copyWith(
      confirmNew: confirmPassword,
      status: Formz.validate([
        state.oldPassword,
        state.newPassword,
        confirmPassword,
      ]),
    );
    emit(s);
  }

  void toggleOldPasswordObscure() {
    emit(state.copyWith(oldPasswordObscured: !state.oldPasswordObscured));
  }

  void toggleNewPasswordObscure() {
    emit(state.copyWith(newPasswordObscured: !state.newPasswordObscured));
  }

  void toggleConfirmPasswordObscure() {
    emit(state.copyWith(
        confirmPasswordObscured: !state.confirmPasswordObscured));
  }

  void onChangePassword() async {
    final oldPassword = Password.dirty(state.oldPassword.value);
    final newPassword = Password.dirty(state.newPassword.value);
    final confirmPassword = ConfirmPassword.dirty(
      password: newPassword.value,
      value: state.confirmNew.value,
    );
    emit(state.copyWith(
      oldPassword: oldPassword,
      newPassword: newPassword,
      confirmNew: confirmPassword,
      status: Formz.validate([
        oldPassword,
        newPassword,
        confirmPassword,
      ]),
    ));

    if (state.status.isValidated) {
      emit(state.copyWith(loading: true, status: FormzStatus.submissionInProgress));
      try {
        await _repo.updateUserPassword(
          oldPassword.value,
          newPassword.value,
          confirmPassword.value,
        );
        emit(state.copyWith(loading: false, status: FormzStatus.submissionSuccess));
      } on Exception catch (e) {
        _handler.handleExceptions(e);
        emit(state.copyWith(loading: false, status: FormzStatus.submissionFailure));
      }
    }
  }
}
