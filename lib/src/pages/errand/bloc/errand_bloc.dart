import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/models/models.dart';
import 'package:repositories/repositories.dart';

part 'errand_event.dart';

part 'errand_state.dart';

class ErrandBloc extends Bloc<ErrandEvent, ErrandState> {
  ErrandBloc({
    required CoordinatorCubit coordinatorCubit,
    required PlacesRepo places,
  })  : _places = places,
        _coordinatorCubit = coordinatorCubit,
        super(ErrandState.initial()) {
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
    _orderItemsSub = coordinatorCubit.cartItems.listen((items) {
      final action = ErrandAction.OnOrderItemsAdded;
      final event = ErrandEvent(action, items);
      add(event);
    });
    _errandOrderSub = coordinatorCubit.errandOrder.listen((order) {
      final action = ErrandAction.OnErrandOrderChanged;
      final event = ErrandEvent(action, order);
      add(event);
    });
  }

  final PlacesRepo _places;
  final CoordinatorCubit _coordinatorCubit;

  late StreamSubscription _storeAddressSub;
  late StreamSubscription _deliveryAddressSub;
  late StreamSubscription _orderItemsSub;
  late StreamSubscription _errandOrderSub;

  @override
  Stream<ErrandState> mapEventToState(ErrandEvent event) async* {
    switch (event.action) {
      case ErrandAction.OnStoreNameChanged:
        String? name = event.args as String?;
        yield state.copyWith(storeName: name);
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
        List<CartItem> arg = event.args as List<CartItem>;
        final total = _calculateTotalPrice(arg);
        yield state.copyWith(cartItems: arg, totalPrice: total);
        break;
      case ErrandAction.OnErrandOrderChanged:
        ErrandOrder order = event.args as ErrandOrder;
        yield state.copyWith(
          senderName: order.senderName,
          senderPhone: order.senderPhone,
          receiverName: order.receiverName,
          receiverPhone: order.receiverPhone,
          deliveryNote: order.deliveryNote,
          paymentType: order.paymentType,
        );
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
  Future<void> close() async {
    final order = await _coordinatorCubit.errandOrder.first;
    _coordinatorCubit.setErrandOrder(order.copyWith(
      storeName: state.storeName,
      orderItems: state.cartItems,
      totalPrice: state.totalPrice,
      storeLocation: Location.fromPlace(state.storeDetail),
      destinationLocation: Location.fromPlace(state.deliveryDetail),
    ));
    _storeAddressSub.cancel();
    _deliveryAddressSub.cancel();
    _orderItemsSub.cancel();
    _errandOrderSub.cancel();
    return super.close();
  }
}
