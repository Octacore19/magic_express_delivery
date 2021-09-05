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
  OnSetStoreAddressDetail,
  OnSetDeliveryAddressDetail,
  OnStoreDetailChanged,
  OnDeliveryDetailChanged,
  OnErrandOrderChanged,
  OnItemRemoved,
  OnOrderItemsAdded,
}
