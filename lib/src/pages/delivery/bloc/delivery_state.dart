part of 'delivery_bloc.dart';

class DeliveryState extends Equatable {
  const DeliveryState._({
    required this.pickupAddress,
    required this.deliveryAddress,
    required this.pickupDetail,
    required this.deliveryDetail,
    required this.cartItems,
    required this.totalPrice,
    required this.order,
    required this.status,
    required this.message,
  });

  factory DeliveryState.initial() {
    return DeliveryState._(
      pickupAddress: '',
      deliveryAddress: '',
      pickupDetail: PlaceDetail.empty(),
      deliveryDetail: PlaceDetail.empty(),
      cartItems: List.empty(),
      totalPrice: 0,
      order: DeliveryOrder.empty(),
      status: Status.initial,
      message: '',
    );
  }

  final String pickupAddress;
  final String deliveryAddress;
  final PlaceDetail pickupDetail;
  final PlaceDetail deliveryDetail;

  final List<CartItem> cartItems;
  final double totalPrice;

  final DeliveryOrder order;
  final Status status;
  final String message;

  bool get buttonActive =>
      !loading &&
      cartItems.isNotEmpty &&
      !pickupDetail.empty &&
      !deliveryDetail.empty;

  bool get sender => order.personnelType == PersonnelType.sender;

  bool get receiver => order.personnelType == PersonnelType.receiver;

  bool get thirdParty => order.personnelType == PersonnelType.thirdParty;

  bool get loading => status == Status.loading;

  int get totalQuantity {
    int total = 0;
    cartItems.forEach((e) {
      total += int.parse(e.quantity);
    });
    return total;
  }

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
    DeliveryOrder? order,
    Status? status,
    String? message,
  }) {
    return DeliveryState._(
      pickupAddress: pickupAddress ?? this.pickupAddress,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      pickupDetail: pickupDetail ?? this.pickupDetail,
      deliveryDetail: deliveryDetail ?? this.deliveryDetail,
      cartItems: cartItems ?? this.cartItems,
      totalPrice: totalPrice ?? this.totalPrice,
      order: order ?? this.order,
      status: status ?? this.status,
      message: message ?? '',
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
        order,
        status,
        message,
      ];
}
