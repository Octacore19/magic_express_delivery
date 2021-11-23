import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:repositories/repositories.dart';

class SendEmailState extends Equatable {
  const SendEmailState._({
    required this.loading,
    required this.status,
    required this.email,
  });

  factory SendEmailState.init() {
    return SendEmailState._(
      loading: false,
      status: FormzStatus.pure,
      email: Email.pure(),
    );
  }

  final bool loading;
  final FormzStatus status;
  final Email email;

  SendEmailState copyWith({
    bool? loading,
    FormzStatus? status,
    Email? email,
  }) {
    return SendEmailState._(
      loading: loading ?? this.loading,
      status: status ?? this.status,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [loading, status, email];
}

class SendEmailCubit extends Cubit<SendEmailState> {
  SendEmailCubit({
    required AuthRepo authRepo,
    required ErrorHandler errorHandler,
  })  : _handler = errorHandler,
        _authRepo = authRepo,
        super(SendEmailState.init());

  final AuthRepo _authRepo;
  final ErrorHandler _handler;

  void onEmailChanged(String email) {
    final e = Email.dirty(email);
    emit(state.copyWith(email: e, status: Formz.validate([e])));
  }

  void onEmailUnFocused() {
    final email = Email.dirty(state.email.value);
    emit(state.copyWith(email: email, status: Formz.validate([email])));
  }

  void onSubmitVerificationEmail() async {
    final email = Email.dirty(state.email.value);
    emit(state.copyWith(status: Formz.validate([email]), email: email));
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _authRepo.resendVerification(state.email.value);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } on Exception catch (e) {
        _handler.handleExceptions(e);
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

  void onSubmitForgotPassword() async {
    emit(state.copyWith(loading: true));
    try {
      await _authRepo.forgotPassword(state.email.value);
      emit(state.copyWith(loading: false, status: FormzStatus.submissionSuccess));
    } on Exception catch (e) {
      _handler.handleExceptions(e);
      emit(state.copyWith(loading: false, status: FormzStatus.submissionFailure));
    }
  }
}
