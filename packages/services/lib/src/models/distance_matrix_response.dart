class DistanceMatrixResponse {
  const DistanceMatrixResponse._({
    required this.destinationAddresses,
    required this.originAddresses,
    required this.rows,
  });

  factory DistanceMatrixResponse.fromJson(Map<String, dynamic> json) {
    return DistanceMatrixResponse._(
      destinationAddresses: (json['destination_addresses'] as List).map((e) => e as String).toList(),
      originAddresses: (json['origin_addresses'] as List).map((e) => e as String).toList(),
      rows: (json['rows'] as List)
          .map((e) => DistanceRowResponse.fromJson(e))
          .toList(),
    );
  }

  final List<String>? destinationAddresses;
  final List<String>? originAddresses;
  final List<DistanceRowResponse>? rows;

  @override
  String toString() {
    return '$runtimeType('
        'destinationAddresses: $destinationAddresses, '
        'originAddresses: $originAddresses, '
        'rows: $rows'
        ')';
  }
}

class DistanceRowResponse {
  const DistanceRowResponse._({
    required this.elements,
  });

  factory DistanceRowResponse.fromJson(Map<String, dynamic> json) {
    return DistanceRowResponse._(
      elements: (json['elements'] as List)
          .map((e) => DistanceElementResponse.fromJson(e))
          .toList(),
    );
  }

  final List<DistanceElementResponse>? elements;

  @override
  String toString() {
    return '$runtimeType(elements: $elements)';
  }
}

class DistanceElementResponse {
  const DistanceElementResponse._({
    required this.distance,
    required this.duration,
    required this.trafficDuration,
  });

  factory DistanceElementResponse.fromJson(Map<String, dynamic> json) {
    return DistanceElementResponse._(
      distance: TextValueObjectResponse.fromJson(json['distance']),
      duration: TextValueObjectResponse.fromJson(json['duration']),
      trafficDuration: json[''],
    );
  }

  final TextValueObjectResponse? distance;
  final TextValueObjectResponse? duration;
  final Object? trafficDuration;

  @override
  String toString() {
    return '$runtimeType('
        'distance: $distance, '
        'duration: $duration, '
        'trafficDuration: $trafficDuration'
        ')';
  }
}

class TextValueObjectResponse {
  const TextValueObjectResponse._({
    required this.text,
    required this.value,
  });

  factory TextValueObjectResponse.fromJson(Map<String, dynamic> json) {
    return TextValueObjectResponse._(text: json['text'], value: json['value']);
  }

  final String? text;
  final int? value;

  @override
  String toString() {
    return '$runtimeType(text: $text, value: $value)';
  }
}
