import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:repositories/repositories.dart';

part 'errand_event.dart';

part 'errand_state.dart';

class ErrandBloc extends Bloc<ErrandEvent, ErrandState> {
  ErrandBloc({
    required OptionsCubit optionsCubit,
    required PlacesRepo places,
  })  : _places = places,
        super(ErrandState()) {
    optionsCubit.state;
    _storeAddressSub = places.pickupDetail.listen((detail) {
      emit(state.copyWith(storeDetail: detail));
    });
    _deliveryAddressSub = places.destinationDetail.listen((detail) {
      emit(state.copyWith(deliveryDetail: detail));
    });
  }

  final PlacesRepo _places;

  late StreamSubscription _storeAddressSub;
  late StreamSubscription _deliveryAddressSub;

  @override
  Stream<ErrandState> mapEventToState(ErrandEvent event) async* {
    switch (event.action) {
      case ErrandAction.OnStoreNameChanged:
        String? name = event.args as String?;
        yield state.copyWith(storeName: name);
        break;
      case ErrandAction.onStoreAddressChanged:
        String? add = event.args as String?;
        yield state.copyWith(storeAddress: add);
        break;
      case ErrandAction.OnDeliveryAddressChanged:
        String? address = event.args as String?;
        yield state.copyWith(deliveryAddress: address);
        break;
      case ErrandAction.OnItemNameChanged:
        String? name = event.args as String?;
        yield state.copyWith(itemName: name);
        break;
      case ErrandAction.OnItemDescriptionChanged:
        String? desc = event.args as String?;
        yield state.copyWith(description: desc);
        break;
      case ErrandAction.OnItemQuantityChanged:
        String? quantity = event.args as String?;
        yield state.copyWith(quantity: quantity);
        break;
      case ErrandAction.OnItemPriceChanged:
        String? price = event.args as String?;
        yield state.copyWith(unitPrice: price);
        break;
      case ErrandAction.OnItemAdded:
        yield _mapOnItemAdded(state);
        break;
      case ErrandAction.OnItemRemoved:
        yield _mapOnItemRemoved(state, event);
        break;
      case ErrandAction.OnSetStoreAddressDetail:
        _fetchStoreDetail(event);
        break;
      case ErrandAction.OnSetDeliveryAddressDetail:
        _fetchDestinationDetail(event);
        break;
    }
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

  void _fetchStoreDetail(ErrandEvent event) async {
    Prediction? prediction = event.args as Prediction?;
    if (prediction != null) {
      try {
        _places.fetchPickupDetail(prediction.id);
      } catch (e) {
        print(e);
      }
    }
  }

  void _fetchDestinationDetail(ErrandEvent event) async {
    Prediction? prediction = event.args as Prediction?;
    if (prediction != null) {
      try {
        _places.fetchDestinationDetail(prediction.id);
      } catch (e) {
        print(e);
      }
    }
  }

  Future<List<Prediction>> searchPlaces(String keyword) async {
    List<Prediction> predictions = List.empty(growable: true);
    try {
      if (keyword.isNotEmpty)
        predictions = await _places.searchForPlaces(keyword);
    } on Exception catch (e) {
      throw e;
    }
    return predictions;
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

  @override
  Future<void> close() {
    _storeAddressSub.cancel();
    _deliveryAddressSub.cancel();
    return super.close();
  }
}
