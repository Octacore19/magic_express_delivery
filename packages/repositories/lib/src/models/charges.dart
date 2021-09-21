import 'package:equatable/equatable.dart';
import 'package:services/services.dart';

class Charges extends Equatable {
  const Charges._({
    required this.pricePerKm,
    required this.basePrice,
  });

  factory Charges.empty() {
    return Charges._(
      pricePerKm: 1,
      basePrice: 0,
    );
  }

  factory Charges.fromResponse(ChargesResponse response) {
    final price = response.pricePerKm ?? 1;
    return Charges._(
      pricePerKm: price == 0 ? 1 : price,
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
