import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:repositories/repositories.dart';

part 'errand_event.dart';

part 'errand_state.dart';

class ErrandBloc extends Bloc<ErrandEvent, ErrandState> {
  ErrandBloc({
    required CoordinatorCubit coordinatorCubit,
    required PlacesRepo places,
  })  : _places = places,
        _coordinatorCubit = coordinatorCubit,
        super(ErrandState()) {
    _storeAddressSub = places.pickupDetail.listen((detail) {
      final action = ErrandAction.OnStoreDetailChanged;
      final event = ErrandEvent(action, detail);
      add(event);
    });
    _deliveryAddressSub = places.destinationDetail.listen((detail) {
      final action = ErrandAction.OnDeliveryDetailChanged;
      final event = ErrandEvent(action, detail);
      add(event);
    });
    _orderItemsSub = coordinatorCubit.stream.listen((s) {
      final action = ErrandAction.OnOrderItemsAdded;
      final event = ErrandEvent(action, s.cartItems);
      add(event);
    });
  }

  final PlacesRepo _places;
  final CoordinatorCubit _coordinatorCubit;

  late StreamSubscription _storeAddressSub;
  late StreamSubscription _deliveryAddressSub;
  late StreamSubscription _orderItemsSub;

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
      case ErrandAction.OnSetStoreAddressDetail:
        _fetchStoreDetail(event);
        break;
      case ErrandAction.OnSetDeliveryAddressDetail:
        _fetchDestinationDetail(event);
        break;
      case ErrandAction.OnItemRemoved:
        yield _mapOnItemRemoved(state, event);
        break;
      case ErrandAction.OnStoreDetailChanged:
        PlaceDetail? arg = event.args as PlaceDetail?;
        yield state.copyWith(storeDetail: arg);
        break;
      case ErrandAction.OnDeliveryDetailChanged:
        PlaceDetail? arg = event.args as PlaceDetail?;
        yield state.copyWith(deliveryDetail: arg);
        break;
      case ErrandAction.OnOrderItemsAdded:
        ErrandState state = this.state;
        List<CartItem>? arg = event.args as List<CartItem>?;
        if (arg != null) {
          final total = _calculateTotalPrice(arg);
          state = state.copyWith(cartItems: arg, totalPrice: total);
        }
        yield state;
        break;
    }
  }

  ErrandState _mapOnItemRemoved(ErrandState state, ErrandEvent event) {
    int position = event.args as int;
    List<CartItem> l = List.from(state.cartItems)..removeAt(position);
    _coordinatorCubit.setCartItems(l);
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
    _orderItemsSub.cancel();
    return super.close();
  }
}
