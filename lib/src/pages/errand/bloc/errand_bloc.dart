import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paystack_client/flutter_paystack_client.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/models/models.dart';
import 'package:repositories/repositories.dart';

part 'errand_event.dart';

part 'errand_state.dart';

class ErrandBloc extends Bloc<ErrandEvent, ErrandState> {
  ErrandBloc({
    required CoordinatorCubit coordinatorCubit,
    required PlacesRepo placesRepo,
    required OrdersRepo ordersRepo,
    required ErrorHandler errorHandler,
  })  : _placesRepo = placesRepo,
        _coordinatorCubit = coordinatorCubit,
        _ordersRepo = ordersRepo,
        _handler = errorHandler,
        super(ErrandState.init(charges: ordersRepo.charges)) {
    _storeAddressSub = _placesRepo.pickupDetail.listen((detail) {
      final action = ErrandAction.OnStoreDetailChanged;
      final event = ErrandEvent(action, detail);
      add(event);
    });
    _deliveryAddressSub = _placesRepo.destinationDetail.listen((detail) {
      final action = ErrandAction.OnDeliveryDetailChanged;
      final event = ErrandEvent(action, detail);
      add(event);
    });
    _orderItemsSub = coordinatorCubit.cartItems.listen((items) {
      final action = ErrandAction.OnCartItemsAdded;
      final event = ErrandEvent(action, items);
      add(event);
    });
    _errandOrderSub = coordinatorCubit.errandOrder.listen((order) {
      final action = ErrandAction.OnErrandOrderChanged;
      final event = ErrandEvent(action, order);
      add(event);
    });
    _completeOrderSub = ordersRepo.order.listen((order) {
      final action = ErrandAction.OnCompletedOrderPlacement;
      final event = ErrandEvent(action, order);
      add(event);
    });
  }

  final PlacesRepo _placesRepo;
  final CoordinatorCubit _coordinatorCubit;
  final ErrorHandler _handler;
  final OrdersRepo _ordersRepo;

  late StreamSubscription _storeAddressSub;
  late StreamSubscription _deliveryAddressSub;
  late StreamSubscription _orderItemsSub;
  late StreamSubscription _errandOrderSub;
  late StreamSubscription _completeOrderSub;

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
        if (state.deliveryDetail.notEmpty) {
          final action = ErrandAction.CalculateDistanceAndTime;
          final event = ErrandEvent(action);
          add(event);
        }
        break;
      case ErrandAction.OnDeliveryDetailChanged:
        PlaceDetail? arg = event.args as PlaceDetail?;
        yield state.copyWith(deliveryDetail: arg);
        if (state.storeDetail.notEmpty) {
          final action = ErrandAction.CalculateDistanceAndTime;
          final event = ErrandEvent(action);
          add(event);
        }
        break;
      case ErrandAction.OnCartItemsAdded:
        List<CartItem> arg = event.args as List<CartItem>;
        final total = _calculateTotalPrice(arg);
        yield state.copyWith(cartItems: arg, totalCartPrice: total);
        break;
      case ErrandAction.OnErrandOrderChanged:
        ErrandOrder order = event.args as ErrandOrder;
        yield state.copyWith(errandOrder: order);
        break;
      case ErrandAction.OnOrderSubmitted:
        yield* _mapOnOrderSubmitted(event, state);
        break;
      case ErrandAction.OnCompletedOrderPlacement:
        Order order = event.args as Order;
        yield state.copyWith(order: order);
        break;
      case ErrandAction.CalculateDistanceAndTime:
        yield* _mapCalculateDistanceAndTime(event, state);
        break;
    }
  }

  String _startPlaceId = '';
  String _endPlaceId = '';

  Stream<ErrandState> _mapCalculateDistanceAndTime(
    ErrandEvent event,
    ErrandState state,
  ) async* {
    try {
      final res = await _placesRepo.getDistanceCalc(_startPlaceId, _endPlaceId);
      yield state.copyWith(
        distance: res.element.distance,
        duration: res.element.duration,
      );
    } on Exception catch (e) {
      _handler.handleExceptionsWithAction(e, () => add(event));
      yield state.copyWith(status: Status.error);
    }
  }

  Stream<ErrandState> _mapOnOrderSubmitted(
    ErrandEvent event,
    ErrandState state,
  ) async* {
    yield state.copyWith(status: Status.loading);
    try {
      final order = state.errandOrder.copyWith(
        storeName: state.storeName,
        orderItems: state.cartItems,
        storeLocation: Location.fromPlace(state.storeDetail),
        destinationLocation: Location.fromPlace(state.deliveryDetail),
        totalPrice: state.totalCartPrice,
      );
      await _ordersRepo.createOrder(order.toJson());
      yield state.copyWith(status: Status.success);
    } on NoDataException {
      yield state.copyWith(status: Status.error, message: 'No order created');
    } on Exception catch (e) {
      _handler.handleExceptionsWithAction(e, () => add(event));
      yield state.copyWith(status: Status.error);
    }
  }

  ErrandState _mapOnItemRemoved(ErrandState state, ErrandEvent event) {
    int position = event.args as int;
    List<CartItem> l = List.from(state.cartItems)..removeAt(position);
    _coordinatorCubit.setCartItems(l);
    return state.copyWith(
      cartItems: l,
      totalCartPrice: _calculateTotalPrice(l),
    );
  }

  void _fetchStoreDetail(ErrandEvent event) async {
    Prediction? prediction = event.args as Prediction?;
    if (prediction != null) {
      try {
        _startPlaceId = prediction.id;
        _placesRepo.fetchPickupDetail(prediction.id);
      } catch (e) {
        print(e);
      }
    }
  }

  void _fetchDestinationDetail(ErrandEvent event) async {
    Prediction? prediction = event.args as Prediction?;
    if (prediction != null) {
      try {
        _endPlaceId = prediction.id;
        _placesRepo.fetchDestinationDetail(prediction.id);
      } catch (e) {
        print(e);
      }
    }
  }

  Charge createCharge() {
    print('Reference: => ${state.order.reference}');
    return Charge()
      ..email = 'test@email.com'
      ..reference = state.order.reference
      ..amount = (state.totalAmount * 100).toInt();
  }

  Future<List<Prediction>> searchPlaces(String keyword) {
    try {
      if (keyword.isEmpty) throw Exception();
      return _placesRepo.searchForPlaces(keyword);
    } on Exception catch (e) {
      throw e;
    }
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
      totalPrice: state.totalCartPrice,
      storeLocation: Location.fromPlace(state.storeDetail),
      destinationLocation: Location.fromPlace(state.deliveryDetail),
    ));
    _storeAddressSub.cancel();
    _deliveryAddressSub.cancel();
    _orderItemsSub.cancel();
    _errandOrderSub.cancel();
    _completeOrderSub.cancel();
    return super.close();
  }
}
