class ChargesResponse {
  const ChargesResponse._({
    required this.pricePerKm,
    required this.basePrice,
  });

  factory ChargesResponse.fromJson(Map<String, dynamic> json) {
    return ChargesResponse._(
      pricePerKm: json['price_per_km'],
      basePrice: json['base_price'],
    );
  }

  final int? basePrice;
  final int? pricePerKm;

  @override
  String toString() {
    return '$runtimeType('
        'basePrice: $basePrice, '
        'pricePerKm: $pricePerKm'
        ')';
  }
}
