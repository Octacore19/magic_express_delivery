class ChargesResponse {
  const ChargesResponse._({
    required this.deliveryBasePrice,
    required this.deliveryPricePerKm,
    required this.errandBasePrice,
    required this.errandPricePerKm,
  });

  factory ChargesResponse.fromJson(Map<String, dynamic> json) {
    return ChargesResponse._(
      deliveryPricePerKm: json['dispatch_price_per_km'],
      deliveryBasePrice: json['dispatch_base_price'],
      errandBasePrice: json['errand_base_price'],
      errandPricePerKm: json['errand_price_per_km'],
    );
  }

  final int? deliveryBasePrice;
  final int? deliveryPricePerKm;
  final int? errandBasePrice;
  final int? errandPricePerKm;

  @override
  String toString() {
    return '$runtimeType('
        'deliveryBasePrice: $deliveryBasePrice, '
        'deliveryPricePerKm: $deliveryPricePerKm, '
        'errandBasePrice: $errandBasePrice, '
        'errandPricePerKm: $errandPricePerKm'
        ')';
  }
}
