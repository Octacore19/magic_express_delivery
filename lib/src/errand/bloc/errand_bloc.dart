import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/errand/model/cart_item.dart';
import 'package:magic_express_delivery/src/options/options.dart';

part 'errand_event.dart';
part 'errand_state.dart';

class ErrandBloc extends Bloc<ErrandEvent, ErrandState> {

  ErrandBloc(OptionsCubit optionsCubit): super(ErrandState()){
    optionsCubit.state;
  }

  @override
  Stream<ErrandState> mapEventToState(ErrandEvent event) async* {
    switch (event.event) {
      case ErrandEvents.OnStoreNameChanged:
        yield _mapOnStoreNameChanged(state, event);
        break;
      case ErrandEvents.onStoreAddressChanged:
        yield _mapOnStoreAddressChanged(state, event);
        break;
      case ErrandEvents.OnDeliveryAddressChanged:
        yield _mapOnDeliveryAddressChanged(state, event);
        break;
      case ErrandEvents.OnItemNameChanged:
        yield _mapOnItemNameChanged(state, event);
        break;
      case ErrandEvents.OnItemDescriptionChanged:
        yield _mapOnItemDescriptionChanged(state, event);
        break;
      case ErrandEvents.OnItemQuantityChanged:
        yield _mapOnItemQuantityChanged(state, event);
        break;
      case ErrandEvents.OnItemPriceChanged:
        yield _mapOnItemUnitPriceChanged(state, event);
        break;
      case ErrandEvents.OnItemAdded:
        yield _mapOnItemAdded(state);
        break;
      case ErrandEvents.OnItemRemoved:
        yield _mapOnItemRemoved(state, event);
        break;
    }
  }

  ErrandState _mapOnStoreNameChanged(ErrandState state, ErrandEvent event) {
    String? name = event.args as String?;
    return state.copyWith(storeName: name);
  }

  ErrandState _mapOnStoreAddressChanged(ErrandState state, ErrandEvent event) {
    String? add = event.args as String?;
    return state.copyWith(storeAddress: add);
  }

  ErrandState _mapOnDeliveryAddressChanged(ErrandState state, ErrandEvent event) {
    String? add = event.args as String?;
    return state.copyWith(deliveryAddress: add);
  }

  ErrandState _mapOnItemNameChanged(ErrandState state, ErrandEvent event) {
    String? name = event.args as String?;
    return state.copyWith(itemName: name);
  }

  ErrandState _mapOnItemDescriptionChanged(ErrandState state, ErrandEvent event) {
    String? desc = event.args as String?;
    return state.copyWith(description: desc);
  }

  ErrandState _mapOnItemQuantityChanged(ErrandState state, ErrandEvent event) {
    String? q = event.args as String?;
    return state.copyWith(quantity: q);
  }

  ErrandState _mapOnItemUnitPriceChanged(ErrandState state, ErrandEvent event) {
    String? q = event.args as String?;
    return state.copyWith(unitPrice: q);
  }

  ErrandState _mapOnItemAdded(ErrandState state) {
    final item = CartItem(
      name: state.itemName,
      description: state.description,
      quantity: state.quantity,
      unitPrice: state.unitPrice,
    );
    List<CartItem> l = List.from(state.cartItems)..add(item);

    return state.copyWith(
      cartItems: l,
      itemName: '',
      description: '',
      quantity: '',
      unitPrice: '',
      totalPrice: _calculateTotalPrice(l),
    );
  }

  ErrandState _mapOnItemRemoved(ErrandState state, ErrandEvent event) {
    int position = event.args as int;
    List<CartItem> l = List.from(state.cartItems)..removeAt(position);
    return state.copyWith(
      cartItems: l,
      totalPrice: _calculateTotalPrice(l),
    );
  }

  double _calculateTotalPrice(List<CartItem> items) {
    double p = 0;
    items.forEach((element) {
      final v = double.parse(element.unitPrice);
      final q = int.parse(element.quantity);
      double i = v * q;
      p += i;
    });
    return p;
  }
}