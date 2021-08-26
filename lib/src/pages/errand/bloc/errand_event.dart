part of 'errand_bloc.dart';

class ErrandEvent extends Equatable {
  const ErrandEvent(this.event, [this.args]);

  final ErrandEvents event;
  final Object? args;

  @override
  List<Object?> get props => [event, args];
}

enum ErrandEvents {
  OnStoreNameChanged,
  onStoreAddressChanged,
  OnDeliveryAddressChanged,
  OnItemNameChanged,
  OnItemDescriptionChanged,
  OnItemQuantityChanged,
  OnItemPriceChanged,
  OnItemAdded,
  OnItemRemoved,
}
