import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/models/models.dart';
import 'package:repositories/repositories.dart';

part 'cart_state.dart';

class CartCubit extends HydratedCubit<CartState> {
  CartCubit({required CoordinatorCubit coordinatorCubit})
      : _coordinatorCubit = coordinatorCubit,
        super(CartState.initial());

  final CoordinatorCubit _coordinatorCubit;

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

  @override
  CartState? fromJson(Map<String, dynamic> json) {
    return CartState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(CartState state) {
    return state.toJson();
  }
}
