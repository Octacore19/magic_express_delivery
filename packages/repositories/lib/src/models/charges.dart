import 'package:equatable/equatable.dart';
import 'package:services/services.dart';

class Charges extends Equatable {
  const Charges._({
    required this.pricePerKm,
    required this.basePrice,
  });

  factory Charges.empty() {
    return Charges._(
      pricePerKm: 0,
      basePrice: 0,
    );
  }

  factory Charges.fromResponse(ChargesResponse response) {
    return Charges._(
      pricePerKm: response.pricePerKm ?? 0,
      basePrice: response.basePrice ?? 0,
    );
  }

  final int basePrice;
  final int pricePerKm;

  @override
  String toString() {
    return '$runtimeType('
        'basePrice: $basePrice, '
        'pricePerKm: $pricePerKm'
        ')';
  }

  @override
  List<Object?> get props => [basePrice, pricePerKm];
}
