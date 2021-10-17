import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/models/models.dart';
import 'package:repositories/repositories.dart';

part 'cart_state.dart';

class CartCubit extends HydratedCubit<CartState> {
  CartCubit({
    required CoordinatorCubit coordinatorCubit,
    bool isDelivery = false,
  })  : _coordinatorCubit = coordinatorCubit,
        _isDelivery = isDelivery,
        super(CartState.initial());

  final CoordinatorCubit _coordinatorCubit;
  final bool _isDelivery;

  void onItemNameChanged(String? value) {
    emit(state.copyWith(itemName: value));
  }

  void onItemDescriptionChanged(String? value) {
    emit(state.copyWith(description: value));
  }

  void onItemQuantityChanged(String? value) {
    emit(state.copyWith(quantity: value));
  }

  void onItemUnitPriceChanged(String? value) {
    emit(state.copyWith(unitPrice: value));
  }

  void onItemAdded() async {
    if (state.itemName.isEmpty) {
      emit(state.copyWith(message: 'Enter an Item name', error: true));
    } else if (state.description.isEmpty) {
      emit(state.copyWith(message: 'Enter description for Item', error: true));
    } else if (state.quantity.isEmpty) {
      emit(state.copyWith(message: 'Quantity cannot be empty', error: true));
    } else if (state.quantity == '0') {
      emit(state.copyWith(message: 'Quantity cannot be zero', error: true));
    } else if (state.unitPrice.isEmpty && !_isDelivery) {
      emit(state.copyWith(message: 'Price cannot be empty', error: true));
    } else {
      final item = CartItem(
        name: state.itemName,
        description: state.description,
        quantity: state.quantity,
        unitPrice: state.unitPrice,
      );
      final _items = await _coordinatorCubit.cartItems.first;
      List<CartItem> l = List.from(_items)..add(item);
      _coordinatorCubit.setCartItems(l);
      emit(CartState.initial());
    }
  }

  @override
  CartState? fromJson(Map<String, dynamic> json) {
    return CartState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(CartState state) {
    return state.toJson();
  }
}
