import 'package:bloc/bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/models/models.dart';
import 'package:repositories/repositories.dart';

class ResendVerifyState extends Equatable {
  const ResendVerifyState._({
    required this.status,
    required this.email,
  });

  factory ResendVerifyState.init() {
    return ResendVerifyState._(
      status: Status.initial,
      email: '',
    );
  }

  final Status status;
  final String email;

  ResendVerifyState copyWith({
    Status? status,
    String? email,
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
    emit(state.copyWith(email: email));
  }

  void onSubmitVerificationEmail() async {
    emit(state.copyWith(status: Status.loading));
    try {
      await _authRepo.resendVerification(state.email);
      emit(state.copyWith(status: Status.success));
    } on Exception catch (e) {
      _handler.handleExceptions(e);
      emit(state.copyWith(status: Status.error));
    }
  }
}
