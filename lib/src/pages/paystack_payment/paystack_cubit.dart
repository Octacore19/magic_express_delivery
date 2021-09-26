import 'package:bloc/bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/models/models.dart';
import 'package:repositories/repositories.dart';

class PaystackState extends Equatable {
  const PaystackState._({
    required this.status,
    required this.reference,
  });

  factory PaystackState.init(String reference) {
    return PaystackState._(
      status: Status.initial,
      reference: reference,
    );
  }

  factory PaystackState.success(String reference) {
    return PaystackState._(
      status: Status.success,
      reference: reference,
    );
  }

  factory PaystackState.failure() {
    return PaystackState._(
      status: Status.error,
      reference: '',
    );
  }

  final Status status;
  final String reference;

  @override
  List<Object?> get props => [status, reference];
}

class PaystackCubit extends Cubit<PaystackState> {
  PaystackCubit({
    required UsersRepo ordersRepo,
    required String reference,
  })  : _ordersRepo = ordersRepo,
        super(PaystackState.init(reference));

  final UsersRepo _ordersRepo;

  void verifyPayment() async {
    try {
      // await _ordersRepo.v
    } on Exception catch (e) {}
  }
}
