import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
        super(DeliveryState()) {
    _storeAddressSub = placesRepo.pickupDetail.listen((detail) {
      emit(state.copyWith(pickupDetail: detail));
    });
    _deliveryAddressSub = placesRepo.destinationDetail.listen((detail) {
      emit(state.copyWith(deliveryDetail: detail));
    });
    _orderItemsSub = coordinatorCubit.stream.listen((s) {
      final total = _calculateTotalPrice(s.cartItems);
      emit(state.copyWith(cartItems: s.cartItems, totalPrice: total));
    });
  }

  final PlacesRepo _placesRepo;
  final CoordinatorCubit _coordinatorCubit;

  late StreamSubscription _storeAddressSub;
  late StreamSubscription _deliveryAddressSub;
  late StreamSubscription _orderItemsSub;

  @override
  Stream<DeliveryState> mapEventToState(DeliveryEvent event) async* {
    switch (event.action) {
      case DeliveryAction.onPickupAddressChanged:
        String? add = event.args as String?;
        yield state.copyWith(pickupAddress: add);
        break;
      case DeliveryAction.OnDeliveryAddressChanged:
        String? address = event.args as String?;
        yield state.copyWith(deliveryAddress: address);
        break;
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
      case DeliveryAction.OnOrderItemsAdded:
        DeliveryState state = this.state;
        List<CartItem>? arg = event.args as List<CartItem>?;
        if (arg != null) {
          final total = _calculateTotalPrice(arg);
          state = state.copyWith(cartItems: arg, totalPrice: total);
        }
        yield state;
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
  Future<void> close() {
    _storeAddressSub.cancel();
    _deliveryAddressSub.cancel();
    _orderItemsSub.cancel();
    return super.close();
  }
}
