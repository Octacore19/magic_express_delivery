part of 'errand_bloc.dart';

class ErrandEvent extends Equatable {
  const ErrandEvent(this.action, [this.args]);

  final ErrandAction action;
  final Object? args;

  @override
  List<Object?> get props => [action, args];
}

enum ErrandAction {
  OnStoreNameChanged,
  onStoreAddressChanged,
  OnDeliveryAddressChanged,
  OnSetStoreAddressDetail,
  OnSetDeliveryAddressDetail,
  OnItemRemoved,
  OnStoreDetailChanged,
  OnDeliveryDetailChanged,
  OnOrderItemsAdded,
}
