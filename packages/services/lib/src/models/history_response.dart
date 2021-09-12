class HistoryResponse {
  const HistoryResponse._({
    required this.id,
    required this.status,
    required this.reference,
    required this.amount,
    required this.startAddress,
    required this.endAddress,
  });

  factory HistoryResponse.fromJson(Map<String, dynamic> json) {
    return HistoryResponse._(
      id: json['id'],
      status: json['order_status'],
      reference: json['transaction_reference'],
      amount: json['total_amount'],
      startAddress: json['pickup_address'],
      endAddress: json['dropoff_address'],
    );
  }

  final int? id;
  final String? status;
  final String? amount;
  final String? reference;
  final String? startAddress;
  final String? endAddress;

  @override
  String toString() {
    return '$runtimeType('
        'id: $id, '
        'status: $status, '
        'reference: $reference, '
        'amount: $amount, '
        'startAddress: $startAddress, '
        'endAddress: $endAddress'
        ')';
  }
}
