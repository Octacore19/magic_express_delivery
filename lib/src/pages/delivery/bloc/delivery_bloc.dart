import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
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
    _senderNameSub = coordinatorCubit.senderName.listen((name) {
      final action = DeliveryAction.OnSenderNameChanged;
      final event = DeliveryEvent(action, name);
      add(event);
    });
    _senderPhoneSub = coordinatorCubit.senderPhoneNumber.listen((phone) {
      final action = DeliveryAction.OnSenderPhoneChanged;
      final event = DeliveryEvent(action, phone);
      add(event);
    });
    _receiverNameSub = coordinatorCubit.receiverName.listen((name) {
      final action = DeliveryAction.OnReceiverNameChanged;
      final event = DeliveryEvent(action, name);
      add(event);
    });
    _receiverPhoneSub = coordinatorCubit.receiverPhoneNumber.listen((phone) {
      final action = DeliveryAction.OnReceiverPhoneChanged;
      final event = DeliveryEvent(action, phone);
      add(event);
    });
    _deliveryNoteSub = coordinatorCubit.deliveryNote.listen((note) {
      final action = DeliveryAction.OnDeliveryNoteChanged;
      final event = DeliveryEvent(action, note);
      add(event);
    });
    _paymentTypeSub = coordinatorCubit.paymentType.listen((type) {
      final action = DeliveryAction.OnPaymentTypedChanged;
      final event = DeliveryEvent(action, type);
      add(event);
    });
  }

  final PlacesRepo _placesRepo;
  final CoordinatorCubit _coordinatorCubit;

  late StreamSubscription _pickupAddressSub;
  late StreamSubscription _deliveryAddressSub;
  late StreamSubscription _orderItemsSub;
  late StreamSubscription _senderNameSub;
  late StreamSubscription _senderPhoneSub;
  late StreamSubscription _receiverNameSub;
  late StreamSubscription _receiverPhoneSub;
  late StreamSubscription _deliveryNoteSub;
  late StreamSubscription _paymentTypeSub;

  @override
  Stream<DeliveryState> mapEventToState(DeliveryEvent event) async* {
    switch (event.action) {
      case DeliveryAction.OnPickupAddressChanged:
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
      case DeliveryAction.OnSenderNameChanged:
        String value = event.args as String;
        yield state.copyWith(senderName: value);
        break;
      case DeliveryAction.OnSenderPhoneChanged:
        String value = event.args as String;
        yield state.copyWith(senderPhone: value);
        break;
      case DeliveryAction.OnReceiverNameChanged:
        String value = event.args as String;
        yield state.copyWith(receiverName: value);
        break;
      case DeliveryAction.OnReceiverPhoneChanged:
        String value = event.args as String;
        yield state.copyWith(receiverPhone: value);
        break;
      case DeliveryAction.OnDeliveryNoteChanged:
        String value = event.args as String;
        yield state.copyWith(deliveryNote: value);
        break;
      case DeliveryAction.OnPaymentTypedChanged:
        PaymentType type = event.args as PaymentType;
        yield state.copyWith(types: type);
        break;
      case DeliveryAction.OnCartItemsAdded:
        List<CartItem> items = event.args as List<CartItem>;
        double total = _calculateTotalPrice(items);
        yield state.copyWith(cartItems: items, totalPrice: total);
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
    _pickupAddressSub.cancel();
    _deliveryAddressSub.cancel();
    _orderItemsSub.cancel();
    _senderNameSub.cancel();
    _senderPhoneSub.cancel();
    _receiverNameSub.cancel();
    _receiverPhoneSub.cancel();
    _deliveryNoteSub.cancel();
    _paymentTypeSub.cancel();
    return super.close();
  }
}
