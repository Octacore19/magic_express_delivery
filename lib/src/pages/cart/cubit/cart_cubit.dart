import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:repositories/repositories.dart';

part 'cart_state.dart';

class CartCubit extends HydratedCubit<CartState> {
  CartCubit({required CoordinatorCubit coordinatorCubit})
      : _coordinatorCubit = coordinatorCubit,
        super(CartState()) {
    _items = coordinatorCubit.state.cartItems;
  }

  final CoordinatorCubit _coordinatorCubit;
  late List<CartItem> _items;

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

  void onItemAdded() {
    CartState state = this.state;
    final item = CartItem(
      name: state.itemName,
      description: state.description,
      quantity: state.quantity,
      unitPrice: state.unitPrice,
    );
    List<CartItem> l = List.from(_items)..add(item);
    _coordinatorCubit.setCartItems(l);
    emit(CartState());
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
