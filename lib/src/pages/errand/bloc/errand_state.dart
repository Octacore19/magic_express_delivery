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
      order: Order.empty(),
      message: '',
      status: Status.initial,
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
  final Order order;
  final Status status;
  final String message;

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

  bool get isPayStackPayment => success && errandOrder.paymentType == PaymentType.card;

  int get totalQuantity {
    int total = 0;
    cartItems.forEach((e) {
      total += int.parse(e.quantity);
    });
    return total;
  }

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

  double get deliveryAmount {
    return charges.basePrice + (distance * charges.pricePerKm);
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
    Order? order,
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
        order: order ?? this.order);
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
      ];
}
