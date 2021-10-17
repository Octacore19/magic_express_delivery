import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  const CartItem._({
    required this.name,
    required this.description,
    required this.quantity,
    required this.unitPrice,
  });

  factory CartItem({
    String? name,
    String? description,
    String? quantity,
    String? unitPrice,
  }) {
    return CartItem._(
      name: name ?? '',
      description: description ?? '',
      quantity: quantity ?? '',
      unitPrice: unitPrice ?? '',
    );
  }

  factory CartItem.empty() {
    return CartItem._(
      name: '',
      description: '',
      quantity: '',
      unitPrice: '',
    );
  }

  final String name;
  final String description;
  final String quantity;
  final String unitPrice;

  CartItem copyWith({
    String? name,
    String? description,
    String? quantity,
    String? unitPrice,
  }) {
    return CartItem._(
      name: name ?? this.name,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item': this.name,
      'quantity': int.tryParse(this.quantity) ?? 0,
      'description': this.description,
      'price': double.tryParse(this.unitPrice) ?? 0,
    };
  }

  @override
  List<Object?> get props => [name, description, quantity, unitPrice];

  @override
  String toString() {
    return 'CartItem(name: $name, '
        'description: $description, '
        'quantity: $quantity, '
        'unitPrice: $unitPrice)';
  }
}
