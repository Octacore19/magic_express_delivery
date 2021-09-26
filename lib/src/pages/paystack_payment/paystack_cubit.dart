import 'package:bloc/bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/models/models.dart';
import 'package:repositories/repositories.dart';

class PaystackState extends Equatable {
  const PaystackState._({
    required this.status,
    required this.reference,
    required this.orderId,
  });

  factory PaystackState.init(String reference, String orderId) {
    return PaystackState._(
      status: Status.initial,
      reference: reference,
      orderId: orderId,
    );
  }

  factory PaystackState.success() {
    return PaystackState._(
      status: Status.success,
      reference: '',
      orderId: '',
    );
  }

  final Status status;
  final String reference;
  final String orderId;

  bool get loading => status == Status.loading;
  bool get success => status == Status.success;

  PaystackState copyWith({
    Status? status,
    String? reference,
    String? orderId,
  }) {
    return PaystackState._(
      status: status ?? this.status,
      reference: reference ?? this.reference,
      orderId: orderId ?? this.orderId,
    );
  }

  @override
  List<Object?> get props => [status, reference, orderId];
}

class PaystackCubit extends Cubit<PaystackState> {
  PaystackCubit({
    required UsersRepo ordersRepo,
    required String reference,
    required String orderId,
    required ErrorHandler errorHandler,
  })  : _ordersRepo = ordersRepo,
        _handler = errorHandler,
        super(PaystackState.init(reference, orderId));

  final UsersRepo _ordersRepo;
  final ErrorHandler _handler;

  void verifyPayment() async {
    emit(state.copyWith(status: Status.loading));
    try {
      await _ordersRepo.verifyPayment(state.reference, state.orderId);
      await _ordersRepo.fetchAllHistory();
      emit(PaystackState.success());
    } on Exception catch (e) {
      emit(state.copyWith(status: Status.error));
      _handler.handleExceptionsWithAction(e, verifyPayment);
    }
  }
}
