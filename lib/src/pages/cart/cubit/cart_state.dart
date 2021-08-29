part of 'cart_cubit.dart';

class CartState extends Equatable {
  CartState({
    this.itemName = '',
    this.description = '',
    this.quantity = '',
    this.unitPrice = '',
  });

  final String itemName;
  final String description;
  final String quantity;
  final String unitPrice;

  CartState copyWith({
    List<CartItem>? cartItems,
    String? itemName,
    String? description,
    String? quantity,
    String? unitPrice,
  }) {
    return CartState(
      itemName: itemName ?? this.itemName,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  CartState.fromJson(Map<String, dynamic> json)
      : itemName = json['itemName'] ?? '',
        description = json['description'] ?? '',
        quantity = json['quantity'] ?? '',
        unitPrice = json['unitPrice'] ?? '';

  Map<String, dynamic> toJson() => {
        'itemName': itemName,
        'description': description,
        'quantity': quantity,
        'unitPrice': unitPrice,
      };

  @override
  List<Object?> get props => [
        itemName,
        description,
        quantity,
        unitPrice,
      ];
}
