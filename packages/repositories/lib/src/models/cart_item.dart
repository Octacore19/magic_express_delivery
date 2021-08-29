import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  const CartItem({
    this.name = '',
    this.description = '',
    this.quantity = '',
    this.unitPrice = '',
  });

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
    return CartItem(
      name: name ?? this.name,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
    );
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
