part of 'errand_bloc.dart';

class ErrandState extends Equatable {
  const ErrandState({
    this.storeName = '',
    this.storeAddress = '',
    this.deliveryAddress = '',
    this.storeDetail = const PlaceDetail.empty(),
    this.deliveryDetail = const PlaceDetail.empty(),
    this.cartItems = const [],
    this.totalPrice = 0,
  });

  final String storeName;
  final String storeAddress;
  final String deliveryAddress;
  final PlaceDetail storeDetail;
  final PlaceDetail deliveryDetail;

  final List<CartItem> cartItems;
  final double totalPrice;

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
  }) {
    return ErrandState(
      storeName: storeName ?? this.storeName,
      storeAddress: storeAddress ?? this.storeAddress,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      storeDetail: storeDetail ?? this.storeDetail,
      deliveryDetail: deliveryDetail ?? this.deliveryDetail,
      cartItems: cartItems ?? this.cartItems,
      totalPrice: totalPrice ?? this.totalPrice,
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
      ];
}
