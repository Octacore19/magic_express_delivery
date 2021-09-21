part of 'cart_cubit.dart';

class CartState extends Equatable {
  CartState._({
    required this.itemName,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.error,
    required this.message,
  });

  factory CartState.initial() {
    return CartState._(
      itemName: '',
      description: '',
      quantity: '',
      unitPrice: '',
      error: false,
      message: '',
    );
  }

  final String itemName;
  final String description;
  final String quantity;
  final String unitPrice;
  final bool error;
  final String message;

  CartState copyWith({
    List<CartItem>? cartItems,
    String? itemName,
    String? description,
    String? quantity,
    String? unitPrice,
    bool? error,
    String? message,
  }) {
    return CartState._(
      itemName: itemName ?? this.itemName,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      error: error ?? false,
      message: message ?? '',
    );
  }

  factory CartState.fromJson(Map<String, dynamic> json) {
    return CartState._(
        itemName: json['itemName'] ?? '',
        description: json['description'] ?? '',
        quantity: json['quantity'] ?? '',
        unitPrice: json['unitPrice'] ?? '',
        error: json['error'] ?? false,
        message: json['message'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'description': description,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'error': error,
      'message': message,
    };
  }

  @override
  List<Object?> get props => [
        itemName,
        description,
        quantity,
        unitPrice,
        error,
        message,
      ];
}
