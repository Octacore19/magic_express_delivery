import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magic_express_delivery/src/app/app.dart';

part 'process_delivery_state.dart';

class ProcessDeliveryCubit extends Cubit<ProcessDeliveryState> {
  ProcessDeliveryCubit({
    required CoordinatorCubit coordinatorCubit,
  })  : _coordinatorCubit = coordinatorCubit,
        super(ProcessDeliveryState()) {
    _taskSub = coordinatorCubit.taskType.listen((type) {
      var state = this.state.copyWith(taskType: type);
      if (type == TaskType.Errand) {
        emit(state.copyWith(paymentSelection: [true, false]));
      } else {
        emit(state.copyWith(paymentSelection: [true]));
      }
    });
    _deliveryTypeSub = coordinatorCubit.deliveryType.listen((type) {
      emit(state.copyWith(deliveryType: type));
    });
  }

  final CoordinatorCubit _coordinatorCubit;
  late StreamSubscription _taskSub;
  late StreamSubscription _deliveryTypeSub;

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
    PaymentType? type;
    for (int i = 0; i < p.length; i++) {
      if (i == index) {
        p[i] = true;
        type = PaymentType.values[i];
      } else {
        p[i] = false;
      }
    }
    emit(state.copyWith(paymentSelection: p, paymentType: type));
    _coordinatorCubit.setPaymentType(type);
  }

  @override
  Future<void> close() {
    _taskSub.cancel();
    _deliveryTypeSub.cancel();
    return super.close();
  }
}
