part of 'errand_bloc.dart';

class ErrandState extends Equatable {
  const ErrandState._({
    required this.storeName,
    required this.storeAddress,
    required this.deliveryAddress,
    required this.storeDetail,
    required this.deliveryDetail,
    required this.cartItems,
    required this.totalCartPrice,
    required this.charges,
    required this.status,
    required this.message,
    required this.errandOrder,
    required this.order,
    required this.estimatedDistance,
    required this.estimatedDuration,
  });

  factory ErrandState.init({required Charges charges}) {
    return ErrandState._(
      storeName: '',
      storeAddress: '',
      deliveryAddress: '',
      storeDetail: PlaceDetail.empty(),
      deliveryDetail: PlaceDetail.empty(),
      cartItems: [],
      totalCartPrice: 0,
      charges: charges,
      errandOrder: ErrandOrder.empty(),
      order: NewOrder.empty(),
      message: '',
      status: Status.initial,
      estimatedDistance: TextValueObject.empty(),
      estimatedDuration: TextValueObject.empty(),
    );
  }

  final String storeName;
  final String storeAddress;
  final String deliveryAddress;
  final PlaceDetail storeDetail;
  final PlaceDetail deliveryDetail;
  final Charges charges;

  final List<CartItem> cartItems;
  final double totalCartPrice;

  final ErrandOrder errandOrder;
  final NewOrder order;
  final Status status;
  final String message;

  final TextValueObject estimatedDistance;
  final TextValueObject estimatedDuration;

  bool get buttonActive =>
      !loading &&
      cartItems.isNotEmpty &&
      storeName.isNotEmpty &&
      !storeDetail.empty &&
      !deliveryDetail.empty;

  bool get sender => errandOrder.personnelType == PersonnelType.sender;

  bool get receiver => errandOrder.personnelType == PersonnelType.receiver;

  bool get thirdParty => errandOrder.personnelType == PersonnelType.thirdParty;

  bool get loading => status == Status.loading;

  bool get success => status == Status.success;

  bool get isPayStackPayment =>
      success && errandOrder.paymentType == PaymentType.card;

  int get totalQuantity {
    int total = 0;
    cartItems.forEach((e) {
      total += int.parse(e.quantity);
    });
    return total;
  }

  double get deliveryAmount {
    final dis = estimatedDistance.value/1000;
    return charges.basePrice +
        (dis * charges.pricePerKm).toDouble();
  }

  double get totalAmount {
    return totalCartPrice + deliveryAmount;
  }

  ErrandState copyWith({
    String? storeName,
    String? storeAddress,
    String? deliveryAddress,
    PlaceDetail? storeDetail,
    PlaceDetail? deliveryDetail,
    List<CartItem>? cartItems,
    double? totalCartPrice,
    Status? status,
    ErrandOrder? errandOrder,
    String? message,
    NewOrder? order,
    TextValueObject? distance,
    TextValueObject? duration,
  }) {
    return ErrandState._(
      storeName: storeName ?? this.storeName,
      storeAddress: storeAddress ?? this.storeAddress,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      storeDetail: storeDetail ?? this.storeDetail,
      deliveryDetail: deliveryDetail ?? this.deliveryDetail,
      cartItems: cartItems ?? this.cartItems,
      totalCartPrice: totalCartPrice ?? this.totalCartPrice,
      charges: this.charges,
      message: message ?? '',
      status: status ?? this.status,
      errandOrder: errandOrder ?? this.errandOrder,
      order: order ?? this.order,
      estimatedDuration: duration ?? this.estimatedDuration,
      estimatedDistance: distance ?? this.estimatedDistance,
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
        totalCartPrice,
        charges,
        message,
        status,
        errandOrder,
        order,
        estimatedDuration,
        estimatedDistance,
      ];
}
