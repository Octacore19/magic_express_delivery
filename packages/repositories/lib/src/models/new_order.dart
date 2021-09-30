import 'package:equatable/equatable.dart';
import 'package:repositories/repositories.dart';
import 'package:services/services.dart';

class NewOrder extends Equatable {
  const NewOrder._({
    required this.id,
    required this.amount,
    required this.reference,
  });

  factory NewOrder.empty() {
    return NewOrder._(
      id: -1,
      amount: 0,
      reference: '',
    );
  }

  factory NewOrder.fromResponse(OrderResponse response) {
    return NewOrder._(
      id: response.id ?? 0,
      amount: double.tryParse(response.amount ?? '') ?? 0,
      reference: response.reference ?? '',
    );
  }

  final int id;
  final double amount;
  final String reference;

  bool get empty => this == NewOrder.empty();

  bool get notEmpty => this == NewOrder.empty();

  @override
  List<Object?> get props => [id, amount, reference];
}
