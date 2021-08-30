import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magic_express_delivery/src/app/app.dart';

part 'process_delivery_state.dart';

class ProcessDeliveryCubit extends Cubit<ProcessDeliveryState> {
  ProcessDeliveryCubit({
    required CoordinatorCubit coordinatorCubit,
  })  : _coordinatorCubit = coordinatorCubit,
        super(ProcessDeliveryState()) {
    final taskType = coordinatorCubit.state.taskType;
    if (taskType == TaskType.Errand) {
      emit(state.copyWith(paymentSelection: [true, false]));
    } else {
      emit(state.copyWith(paymentSelection: [true]));
    }
  }

  final CoordinatorCubit _coordinatorCubit;

  void onSenderNameChanged(String? value) {
    emit(state.copyWith(senderName: value));
    _coordinatorCubit.setSenderName(value);
  }

  void onSenderPhoneChanged(String? value) {
    emit(state.copyWith(senderPhone: value));
    _coordinatorCubit.setSenderPhone(value);
  }

  void onReceiverNameChanged(String? value) {
    emit(state.copyWith(receiverName: value));
    _coordinatorCubit.setReceiverName(value);
  }

  void onReceiverPhoneChanged(String? value) {
    emit(state.copyWith(receiverPhone: value));
    _coordinatorCubit.setReceiverPhone(value);
  }

  void onDeliveryNoteChanged(String? value) {
    emit(state.copyWith(deliveryNote: value));
    _coordinatorCubit.setDeliveryNote(value);
  }

  void onSelectionOptionsChanged(int index) {
    List<bool> p = List.from(state.paymentSelection);
    PaymentTypes? type;
    for (int i = 0; i < p.length; i++) {
      if (i == index) {
        p[i] = true;
        type = PaymentTypes.values[i];
      } else {
        p[i] = false;
      }
    }
    emit(state.copyWith(paymentSelection: p, types: type));
    _coordinatorCubit.setPaymentType(type);
  }
}
