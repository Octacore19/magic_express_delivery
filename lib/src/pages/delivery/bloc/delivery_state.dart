part of 'delivery_bloc.dart';

class DeliveryState extends Equatable {
  const DeliveryState._({
    required this.pickupAddress,
    required this.deliveryAddress,
    required this.pickupDetail,
    required this.deliveryDetail,
    required this.cartItems,
    required this.totalPrice,
    required this.senderName,
    required this.senderPhone,
    required this.receiverName,
    required this.receiverPhone,
    required this.deliveryNote,
    required this.paymentType,
  });

  factory DeliveryState.initial() {
    return DeliveryState._(
      pickupAddress: '',
      deliveryAddress: '',
      pickupDetail: PlaceDetail.empty(),
      deliveryDetail: PlaceDetail.empty(),
      cartItems: List.empty(),
      totalPrice: 0,
      senderPhone: '',
      senderName: '',
      receiverPhone: '',
      receiverName: '',
      deliveryNote: '',
      paymentType: PaymentType.unknown,
    );
  }

  final String pickupAddress;
  final String deliveryAddress;
  final PlaceDetail pickupDetail;
  final PlaceDetail deliveryDetail;

  final List<CartItem> cartItems;
  final double totalPrice;

  final String senderName;
  final String senderPhone;
  final String receiverName;
  final String receiverPhone;
  final String deliveryNote;
  final PaymentType paymentType;

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
    String? senderName,
    String? senderPhone,
    String? receiverName,
    String? receiverPhone,
    String? deliveryNote,
    PaymentType? paymentType,
  }) {
    return DeliveryState._(
      pickupAddress: pickupAddress ?? this.pickupAddress,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      pickupDetail: pickupDetail ?? this.pickupDetail,
      deliveryDetail: deliveryDetail ?? this.deliveryDetail,
      cartItems: cartItems ?? this.cartItems,
      totalPrice: totalPrice ?? this.totalPrice,
      senderName: senderName ?? this.senderName,
      senderPhone: senderPhone ?? this.senderPhone,
      receiverName: receiverName ?? this.receiverName,
      receiverPhone: receiverPhone ?? this.receiverPhone,
      deliveryNote: deliveryNote ?? this.deliveryNote,
      paymentType: paymentType ?? this.paymentType,
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
        senderName,
        senderPhone,
        receiverName,
        receiverPhone,
        deliveryNote,
        paymentType,
      ];
}
