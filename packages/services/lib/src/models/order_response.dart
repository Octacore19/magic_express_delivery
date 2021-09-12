class OrderResponse {
  const OrderResponse._({
    required this.id,
    required this.amount,
    required this.reference,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse._(
      id: json['order_id'],
      amount: json['total_amount'],
      reference: json['transaction_reference'],
    );
  }

  final int? id;
  final String? amount;
  final String? reference;

  @override
  String toString() {
    return '$runtimeType('
        'id: $id, '
        'amount: $amount, '
        'reference: $reference'
        ')';
  }
}
