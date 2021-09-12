import 'package:repositories/repositories.dart';
import 'package:services/services.dart';

class History extends Equatable {
  const History._({
    required this.id,
    required this.status,
    required this.amount,
    required this.reference,
    required this.startAddress,
    required this.endAddress,
  });

  factory History({
    int? id,
    String? status,
    double? amount,
    String? reference,
    String? startAddress,
    String? endAddress,
  }) {
    return History._(
      id: id ?? -1,
      status: status ?? 'Unknown',
      amount: amount ?? 0,
      reference: reference ?? '',
      startAddress: startAddress ?? '',
      endAddress: endAddress ?? ''
    );
  }

  factory History.empty() {
    return History._(
      id: -1,
      status: 'Unknown',
      amount: 0,
      reference: '',
      startAddress: '',
      endAddress: ''
    );
  }

  factory History.fromResponse(HistoryResponse response) {
    return History._(
      id: response.id ?? -1,
      status: response.status ?? 'Unknown',
      amount: double.tryParse(response.amount ?? '') ?? 0,
      reference: response.reference ?? '',
      startAddress: response.startAddress ?? '',
      endAddress: response.endAddress ?? ''
    );
  }

  final int id;
  final String status;
  final double amount;
  final String reference;
  final String startAddress;
  final String endAddress;

  History copyWith({
    int? id,
    String? status,
    double? amount,
    String? reference,
    String? startAddress,
    String? endAddress,
  }) {
    return History._(
      id: id ?? this.id,
      status: status ?? this.status,
      amount: amount ?? this.amount,
      reference: reference ?? this.reference,
      startAddress: startAddress ?? this.startAddress,
      endAddress: endAddress ?? this.endAddress,
    );
  }

  @override
  List<Object?> get props => [id, status, amount, reference, startAddress, endAddress];

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
