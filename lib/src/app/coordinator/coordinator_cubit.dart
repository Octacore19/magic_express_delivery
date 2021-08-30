import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:repositories/repositories.dart';

part 'coordinator_state.dart';

class CoordinatorCubit extends Cubit<CoordinatorState> {
  CoordinatorCubit() : super(CoordinatorState());

  void setTaskType(TaskType type) {
    emit(state.copyWith(taskType: type));
  }

  void setDeliveryType(DeliveryType type) {
    emit(state.copyWith(deliveryType: type));
  }

  void setCartItems(List<CartItem>? items) {
    emit(state.copyWith(cartItems: items));
  }

  void setSenderName(String? value) {
    emit(state.copyWith(senderName: value));
  }

  void setSenderPhone(String? value) {
    emit(state.copyWith(senderPhone: value));
  }

  void setReceiverName(String? value) {
    emit(state.copyWith(receiverName: value));
  }

  void setReceiverPhone(String? value) {
    emit(state.copyWith(receiverPhone: value));
  }

  void setDeliveryNote(String? value) {
    emit(state.copyWith(deliveryNote: value));
  }

  void setPaymentType(PaymentTypes? type) {
    emit(state.copyWith(types: type));
  }
}