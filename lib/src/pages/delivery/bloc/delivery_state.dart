part of 'delivery_bloc.dart';

class DeliveryState extends Equatable {
  DeliveryState({
    this.pickupAddress = '',
    this.deliveryAddress = '',
    this.pickupDetail = const PlaceDetail.empty(),
    this.deliveryDetail = const PlaceDetail.empty(),
    this.cartItems = const [],
    this.totalPrice = 0,
  });

  final String pickupAddress;
  final String deliveryAddress;
  final PlaceDetail pickupDetail;
  final PlaceDetail deliveryDetail;

  final List<CartItem> cartItems;
  final double totalPrice;

  bool get buttonActive =>
      cartItems.isNotEmpty && !pickupDetail.empty && !deliveryDetail.empty;

  double get distance {
    double distance = 0;
    if (!pickupDetail.empty && !deliveryDetail.empty) {
      distance = Geolocator.distanceBetween(
        pickupDetail.latitude,
        pickupDetail.longitude,
        deliveryDetail.latitude,
        deliveryDetail.longitude,
      );
      distance = distance / 1000;
    }
    return distance;
  }

  DeliveryState copyWith({
    String? pickupAddress,
    String? deliveryAddress,
    PlaceDetail? pickupDetail,
    PlaceDetail? deliveryDetail,
    List<CartItem>? cartItems,
    double? totalPrice,
  }) {
    return DeliveryState(
      pickupAddress: pickupAddress ?? this.pickupAddress,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      pickupDetail: pickupDetail ?? this.pickupDetail,
      deliveryDetail: deliveryDetail ?? this.deliveryDetail,
      cartItems: cartItems ?? this.cartItems,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  List<Object?> get props => [
        pickupAddress,
        deliveryAddress,
        pickupDetail,
        deliveryDetail,
        cartItems,
        totalPrice,
      ];
}
