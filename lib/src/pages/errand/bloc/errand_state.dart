part of 'errand_bloc.dart';

class ErrandState extends Equatable {
  const ErrandState._({
    required this.storeName,
    required this.storeAddress,
    required this.deliveryAddress,
    required this.storeDetail,
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

  factory ErrandState.initial() {
    return ErrandState._(
      storeName: '',
      storeAddress: '',
      deliveryAddress: '',
      storeDetail: PlaceDetail.empty(),
      deliveryDetail: PlaceDetail.empty(),
      cartItems: [],
      totalPrice: 0,
      senderPhone: '',
      senderName: '',
      receiverPhone: '',
      receiverName: '',
      deliveryNote: '',
      paymentType: PaymentType.cash,
    );
  }

  final String storeName;
  final String storeAddress;
  final String deliveryAddress;
  final PlaceDetail storeDetail;
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
      cartItems.isNotEmpty &&
      storeName.isNotEmpty &&
      !storeDetail.empty &&
      !deliveryDetail.empty;

  double get distance {
    double distance = 0;
    if (!storeDetail.empty && !deliveryDetail.empty) {
      distance = Geolocator.distanceBetween(
        storeDetail.latitude,
        storeDetail.longitude,
        deliveryDetail.latitude,
        deliveryDetail.longitude,
      );
      distance = distance / 1000;
    }
    return distance;
  }

  ErrandState copyWith({
    String? storeName,
    String? storeAddress,
    String? deliveryAddress,
    PlaceDetail? storeDetail,
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
    return ErrandState._(
      storeName: storeName ?? this.storeName,
      storeAddress: storeAddress ?? this.storeAddress,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      storeDetail: storeDetail ?? this.storeDetail,
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
        storeName,
        storeAddress,
        deliveryAddress,
        storeDetail,
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
