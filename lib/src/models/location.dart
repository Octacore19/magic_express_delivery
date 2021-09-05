import 'package:repositories/repositories.dart';

class Location extends Equatable {
  const Location._({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory Location({
    String? address,
    double? latitude,
    double? longitude,
  }) {
    return Location._(
      address: address ?? '',
      latitude: latitude ?? 0,
      longitude: longitude ?? 0,
    );
  }

  factory Location.empty() {
    return Location._(
      address: '',
      latitude: 0,
      longitude: 0,
    );
  }

  factory Location.fromPlace(PlaceDetail detail) {
    return Location._(
      address: detail.address,
      latitude: detail.latitude,
      longitude: detail.longitude,
    );
  }

  final double longitude;
  final double latitude;
  final String address;

  bool get empty => this == Location.empty();

  bool get notEmpty => this != Location.empty();

  Location copyWith({
    String? address,
    double? longitude,
    double? latitude,
  }) {
    return Location._(
      address: address ?? this.address,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': this.latitude,
      'longitude': this.longitude,
      'address': this.address,
    };
  }

  @override
  List<Object?> get props => [longitude, latitude, address];
}
