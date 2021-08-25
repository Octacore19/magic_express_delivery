part of 'errand_bloc.dart';

class ErrandState extends Equatable {
  const ErrandState({
    this.storeName = '',
    this.storeAddress = '',
    this.deliveryAddress = '',
    this.cartItems = const [],
    this.itemName = '',
    this.description = '',
    this.quantity = '',
    this.unitPrice = '',
    this.totalPrice = 0,
  });

  final String storeName;
  final String storeAddress;
  final String deliveryAddress;
  final List<CartItem> cartItems;

  final String itemName;
  final String description;
  final String quantity;
  final String unitPrice;
  final double totalPrice;

  ErrandState copyWith({
    String? storeName,
    String? storeAddress,
    String? deliveryAddress,
    List<CartItem>? cartItems,
    String? itemName,
    String? description,
    String? quantity,
    String? unitPrice,
    double? totalPrice,
  }) {
    return ErrandState(
      storeName: storeName ?? this.storeName,
      storeAddress: storeAddress ?? this.storeAddress,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      cartItems: cartItems ?? this.cartItems,
      itemName: itemName ?? this.itemName,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  List<Object?> get props => [
        storeName,
        storeAddress,
        deliveryAddress,
        cartItems,
        itemName,
        description,
        quantity,
        unitPrice,
        totalPrice,
      ];
}
