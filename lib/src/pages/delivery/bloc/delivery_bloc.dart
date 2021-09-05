import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:magic_express_delivery/src/models/models.dart';
import 'package:repositories/repositories.dart';
import 'package:magic_express_delivery/src/app/app.dart';

part 'delivery_event.dart';

part 'delivery_state.dart';

class DeliveryBloc extends Bloc<DeliveryEvent, DeliveryState> {
  DeliveryBloc({
    required CoordinatorCubit coordinatorCubit,
    required PlacesRepo placesRepo,
  })  : _placesRepo = placesRepo,
        _coordinatorCubit = coordinatorCubit,
        super(DeliveryState.initial()) {
    _pickupAddressSub = placesRepo.pickupDetail.listen((detail) {
      final action = DeliveryAction.OnPickupDetailChanged;
      final event = DeliveryEvent(action, detail);
      add(event);
    });
    _deliveryAddressSub = placesRepo.destinationDetail.listen((detail) {
      final action = DeliveryAction.OnDeliveryDetailChanged;
      final event = DeliveryEvent(action, detail);
      add(event);
    });
    _orderItemsSub = coordinatorCubit.cartItems.listen((items) {
      final action = DeliveryAction.OnCartItemsAdded;
      final event = DeliveryEvent(action, items);
      add(event);
    });
    _deliveryOrderSub = coordinatorCubit.deliveryOrder.listen((order) {
      final action = DeliveryAction.OnDeliveryOrderChanged;
      final event = DeliveryEvent(action, order);
      add(event);
    });
  }

  final PlacesRepo _placesRepo;
  final CoordinatorCubit _coordinatorCubit;

  late StreamSubscription _pickupAddressSub;
  late StreamSubscription _deliveryAddressSub;
  late StreamSubscription _orderItemsSub;
  late StreamSubscription _deliveryOrderSub;

  @override
  Stream<DeliveryState> mapEventToState(DeliveryEvent event) async* {
    switch (event.action) {
      case DeliveryAction.OnSetPickupAddressDetail:
        _fetchPickupDetail(event);
        break;
      case DeliveryAction.OnSetDeliveryAddressDetail:
        _fetchDestinationDetail(event);
        break;
      case DeliveryAction.OnItemRemoved:
        yield _mapOnItemRemoved(state, event);
        break;
      case DeliveryAction.OnPickupDetailChanged:
        PlaceDetail? arg = event.args as PlaceDetail?;
        yield state.copyWith(pickupDetail: arg);
        break;
      case DeliveryAction.OnDeliveryDetailChanged:
        PlaceDetail? arg = event.args as PlaceDetail?;
        yield state.copyWith(deliveryDetail: arg);
        break;
      case DeliveryAction.OnCartItemsAdded:
        List<CartItem> items = event.args as List<CartItem>;
        double total = _calculateTotalPrice(items);
        yield state.copyWith(cartItems: items, totalPrice: total);
        break;
      case DeliveryAction.OnDeliveryOrderChanged:
        DeliveryOrder order = event.args as DeliveryOrder;
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

  DeliveryState _mapOnItemRemoved(DeliveryState state, DeliveryEvent event) {
    int position = event.args as int;
    List<CartItem> l = List.from(state.cartItems)..removeAt(position);
    _coordinatorCubit.setCartItems(l);
    return state.copyWith(
      cartItems: l,
      totalPrice: _calculateTotalPrice(l),
    );
  }

  void _fetchPickupDetail(DeliveryEvent event) async {
    Prediction? prediction = event.args as Prediction?;
    if (prediction != null) {
      try {
        _placesRepo.fetchPickupDetail(prediction.id);
      } catch (e) {
        print(e);
      }
    }
  }

  void _fetchDestinationDetail(DeliveryEvent event) async {
    Prediction? prediction = event.args as Prediction?;
    if (prediction != null) {
      try {
        _placesRepo.fetchDestinationDetail(prediction.id);
      } catch (e) {
        print(e);
      }
    }
  }

  Future<List<Prediction>> searchPlaces(String keyword) async {
    List<Prediction> predictions = List.empty(growable: true);
    try {
      if (keyword.isNotEmpty && keyword.length > 3)
        predictions = await _placesRepo.searchForPlaces(keyword);
    } on Exception catch (e) {
      throw e;
    }
    return predictions;
  }

  double _calculateTotalPrice(List<CartItem> items) {
    double p = 0;
    items.forEach((element) {
      final v = double.tryParse(element.unitPrice) ?? 0;
      final q = int.tryParse(element.quantity) ?? 0;
      double i = v * q;
      p += i;
    });
    return p;
  }

  @override
  Future<void> close() async {
    final order = await _coordinatorCubit.deliveryOrder.first;
    _coordinatorCubit.setDeliveryOrder(order.copyWith(
      orderItems: state.cartItems,
      totalPrice: state.totalPrice,
      pickupLocation: Location.fromPlace(state.pickupDetail),
      destinationLocation: Location.fromPlace(state.deliveryDetail)
    ));
    _pickupAddressSub.cancel();
    _deliveryAddressSub.cancel();
    _orderItemsSub.cancel();
    _deliveryOrderSub.cancel();
    return super.close();
  }
}
