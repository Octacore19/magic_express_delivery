import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/models/models.dart';

part 'process_delivery_state.dart';

class ProcessDeliveryCubit extends Cubit<ProcessDeliveryState> {
  ProcessDeliveryCubit({
    required CoordinatorCubit coordinatorCubit,
  })  : _coordinatorCubit = coordinatorCubit,
        super(ProcessDeliveryState(orderType: coordinatorCubit.state)) {
    _init();
    _deliveryOrderSub = coordinatorCubit.deliveryOrder.listen((order) {
      emit(state.copyWith(personnelType: order.personnelType));
    });

    _errandOrderSub = coordinatorCubit.errandOrder.listen((order) {
      emit(state.copyWith(personnelType: order.personnelType));
    });
  }

  final CoordinatorCubit _coordinatorCubit;

  late StreamSubscription _deliveryOrderSub;
  late StreamSubscription _errandOrderSub;

  void _init() async {
    if (state.errand) {
      emit(state.copyWith(paymentSelection: [true, false]));
      final order = await _coordinatorCubit.errandOrder.first;
      emit(state.copyWith(personnelType: order.personnelType));
    } else {
      emit(state.copyWith(paymentSelection: [true]));
      final order = await _coordinatorCubit.deliveryOrder.first;
      emit(state.copyWith(personnelType: order.personnelType));
    }
    print(state);
  }

  void onSenderNameChanged(String? value) {
    emit(state.copyWith(senderName: value));
  }

  void onSenderPhoneChanged(String? value) {
    emit(state.copyWith(senderPhone: value));
  }

  void onReceiverNameChanged(String? value) {
    emit(state.copyWith(receiverName: value));
  }

  void onReceiverPhoneChanged(String? value) {
    emit(state.copyWith(receiverPhone: value));
  }

  void onDeliveryNoteChanged(String? value) {
    emit(state.copyWith(deliveryNote: value));
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
  }

  @override
  Future<void> close() async {
    if (state.errand) {
      final order = await _coordinatorCubit.errandOrder.single;
      _coordinatorCubit.setErrandOrder(order.copyWith(
        senderName: state.senderName,
        senderPhone: state.senderPhone,
        receiverName: state.receiverName,
        receiverPhone: state.receiverPhone,
        deliveryNote: state.deliveryNote,
        paymentType: state.paymentType,
      ));
    } else {
      final order = await _coordinatorCubit.deliveryOrder.single;
      _coordinatorCubit.setDeliveryOrder(order.copyWith(
        senderName: state.senderName,
        senderPhone: state.senderPhone,
        receiverName: state.receiverName,
        receiverPhone: state.receiverPhone,
        deliveryNote: state.deliveryNote,
        paymentType: state.paymentType,
      ));
    }
    _deliveryOrderSub.cancel();
    _errandOrderSub.cancel();
    return super.close();
  }
}
