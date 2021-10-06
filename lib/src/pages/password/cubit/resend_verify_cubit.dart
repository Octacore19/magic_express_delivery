import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/models/models.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:repositories/repositories.dart';

class ResendVerifyState extends Equatable {
  const ResendVerifyState._({
    required this.status,
    required this.email,
  });

  factory ResendVerifyState.init() {
    return ResendVerifyState._(
      status: FormzStatus.pure,
      email: Email.pure(),
    );
  }

  final FormzStatus status;
  final Email email;

  ResendVerifyState copyWith({
    FormzStatus? status,
    Email? email,
  }) {
    return ResendVerifyState._(
      status: status ?? this.status,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [status, email];
}

class ResendVerifyCubit extends Cubit<ResendVerifyState> {
  ResendVerifyCubit({
    required AuthRepo authRepo,
    required ErrorHandler errorHandler,
  })  : _handler = errorHandler,
        _authRepo = authRepo,
        super(ResendVerifyState.init());

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
}
