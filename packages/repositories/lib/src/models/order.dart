import 'package:equatable/equatable.dart';
import 'package:repositories/repositories.dart';
import 'package:services/services.dart';

class Order extends Equatable {
  const Order._({
    required this.id,
    required this.amount,
    required this.reference,
  });

  factory Order.empty() {
    return Order._(
      id: -1,
      amount: 0,
      reference: '',
    );
  }

  factory Order.fromResponse(OrderResponse response) {
    return Order._(
      id: response.id ?? 0,
      amount: double.tryParse(response.amount ?? '') ?? 0,
      reference: response.reference ?? '',
    );
  }

  final int id;
  final double amount;
  final String reference;

  bool get empty => this == Order.empty();

  bool get notEmpty => this == Order.empty();

  @override
  List<Object?> get props => [id, amount, reference];
}
