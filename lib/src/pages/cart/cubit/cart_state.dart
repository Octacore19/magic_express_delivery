part of 'cart_cubit.dart';

class CartState extends Equatable {
  CartState._({
    required this.itemName,
    required this.description,
    required this.quantity,
    required this.unitPrice,
  });

  factory CartState({
    String? itemName,
    String? description,
    String? quantity,
    String? unitPrice,
  }) {
    return CartState._(
      itemName: itemName ?? '',
      description: description ?? '',
      quantity: quantity ?? '',
      unitPrice: unitPrice ?? '',
    );
  }

  factory CartState.initial() {
    return CartState._(
      itemName: '',
      description: '',
      quantity: '',
      unitPrice: '',
    );
  }

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

  factory CartState.fromJson(Map<String, dynamic> json) {
    return CartState._(
      itemName: json['itemName'] ?? '',
      description: json['description'] ?? '',
      quantity: json['quantity'] ?? '',
      unitPrice: json['unitPrice'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'description': description,
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }

  @override
  List<Object?> get props => [
        itemName,
        description,
        quantity,
        unitPrice,
      ];
}
