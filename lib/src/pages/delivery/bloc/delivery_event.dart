part of 'delivery_bloc.dart';

class DeliveryEvent extends Equatable {
  const DeliveryEvent(this.action, [this.args]);

  final DeliveryAction action;
  final Object? args;

  @override
  List<Object?> get props => [action, args];
}

enum DeliveryAction {
  OnPickupAddressChanged,
  OnDeliveryAddressChanged,
  OnSetPickupAddressDetail,
  OnSetDeliveryAddressDetail,
  OnItemRemoved,
  OnPickupDetailChanged,
  OnDeliveryDetailChanged,
  OnOrderItemsAdded,
  OnSenderNameChanged,
  OnSenderPhoneChanged,
  OnReceiverNameChanged,
  OnReceiverPhoneChanged,
  OnDeliveryNoteChanged,
  OnPaymentTypedChanged,
  OnCartItemsAdded,
}
