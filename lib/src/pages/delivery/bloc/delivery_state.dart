part of 'delivery_bloc.dart';

class DeliveryState extends Equatable {
  const DeliveryState._({
    required this.pickupAddress,
    required this.deliveryAddress,
    required this.pickupDetail,
    required this.deliveryDetail,
    required this.cartItems,
    required this.totalCartPrice,
    required this.order,
    required this.status,
    required this.message,
    required this.charges,
    required this.estimatedDistance,
    required this.estimatedDuration,
  });

  factory DeliveryState.initial({required Charges charges}) {
    return DeliveryState._(
      pickupAddress: '',
      deliveryAddress: '',
      pickupDetail: PlaceDetail.empty(),
      deliveryDetail: PlaceDetail.empty(),
      cartItems: List.empty(),
      totalCartPrice: 0,
      order: DeliveryOrder.empty(),
      status: Status.initial,
      message: '',
      charges: charges,
      estimatedDistance: TextValueObject.empty(),
      estimatedDuration: TextValueObject.empty(),
    );
  }

  final String pickupAddress;
  final String deliveryAddress;
  final PlaceDetail pickupDetail;
  final PlaceDetail deliveryDetail;
  final Charges charges;

  final List<CartItem> cartItems;
  final double totalCartPrice;

  final DeliveryOrder order;
  final Status status;
  final String message;

  final TextValueObject estimatedDistance;
  final TextValueObject estimatedDuration;

  bool get buttonActive =>
      !loading &&
      cartItems.isNotEmpty &&
      !pickupDetail.empty &&
      !deliveryDetail.empty;

  bool get sender => order.personnelType == PersonnelType.sender;

  bool get receiver => order.personnelType == PersonnelType.receiver;

  bool get thirdParty => order.personnelType == PersonnelType.thirdParty;

  bool get loading => status == Status.loading;

  bool get success => status == Status.success;

  int get totalQuantity {
    int total = 0;
    cartItems.forEach((e) {
      total += int.parse(e.quantity);
    });
    return total;
  }

  double get deliveryAmount {
    final dis = estimatedDistance.value / 1000;
    return charges.basePrice + (dis * charges.pricePerKm).toDouble();
  }

  double get totalAmount {
    return totalCartPrice + deliveryAmount;
  }

  DeliveryState delivered() {
    return DeliveryState._(
      pickupAddress: '',
      deliveryAddress: '',
      pickupDetail: PlaceDetail.empty(),
      deliveryDetail: PlaceDetail.empty(),
      cartItems: [],
      totalCartPrice: 0,
      order: DeliveryOrder.empty(),
      status: Status.success,
      message: '',
      charges: this.charges,
      estimatedDistance: TextValueObject.empty(),
      estimatedDuration: TextValueObject.empty(),
    );
  }

  DeliveryState copyWith({
    String? pickupAddress,
    String? deliveryAddress,
    PlaceDetail? pickupDetail,
    PlaceDetail? deliveryDetail,
    List<CartItem>? cartItems,
    double? totalCartPrice,
    DeliveryOrder? order,
    Status? status,
    String? message,
    TextValueObject? distance,
    TextValueObject? duration,
  }) {
    return DeliveryState._(
      pickupAddress: pickupAddress ?? this.pickupAddress,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      pickupDetail: pickupDetail ?? this.pickupDetail,
      deliveryDetail: deliveryDetail ?? this.deliveryDetail,
      cartItems: cartItems ?? this.cartItems,
      totalCartPrice: totalCartPrice ?? this.totalCartPrice,
      order: order ?? this.order,
      status: status ?? this.status,
      message: message ?? '',
      charges: this.charges,
      estimatedDuration: duration ?? this.estimatedDuration,
      estimatedDistance: distance ?? this.estimatedDistance,
    );
  }

  @override
  List<Object?> get props => [
        pickupAddress,
        deliveryAddress,
        pickupDetail,
        deliveryDetail,
        cartItems,
        totalCartPrice,
        order,
        status,
        message,
        charges,
        estimatedDuration,
        estimatedDistance,
      ];
}
