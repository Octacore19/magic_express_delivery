import 'package:equatable/equatable.dart';
import 'package:services/services.dart';

class Charges extends Equatable {
  const Charges._({
    required this.errandPricePerKm,
    required this.errandBasePrice,
    required this.deliveryBasePrice,
    required this.deliveryPricePerKm,
  });

  factory Charges.empty() {
    return Charges._(
      errandBasePrice: 0,
      errandPricePerKm: 1,
      deliveryBasePrice: 0,
      deliveryPricePerKm: 1,
    );
  }

  factory Charges.fromResponse(ChargesResponse response) {
    print('baseDelivery => ${response.deliveryBasePrice}');
    print('baseErrand => ${response.errandBasePrice}');
    final errandPrice = response.errandPricePerKm ?? 1;
    final deliveryPrice = response.deliveryPricePerKm ?? 1;
    return Charges._(
      errandPricePerKm: errandPrice == 0 ? 1 : errandPrice,
      errandBasePrice: response.errandBasePrice ?? 0,
      deliveryPricePerKm: deliveryPrice == 0 ? 1 : deliveryPrice,
      deliveryBasePrice: response.deliveryBasePrice ?? 0,
    );
  }

  final int deliveryBasePrice;
  final int deliveryPricePerKm;
  final int errandBasePrice;
  final int errandPricePerKm;

  @override
  String toString() {
    return '$runtimeType('
        'deliveryBasePrice: $deliveryBasePrice, '
        'deliveryPricePerKm: $deliveryPricePerKm, '
        'errandBasePrice: $errandBasePrice, '
        'errandPricePerKm: $errandPricePerKm'
        ')';
  }

  @override
  List<Object?> get props => [
        deliveryPricePerKm,
        deliveryBasePrice,
        errandBasePrice,
        errandPricePerKm,
      ];
}
