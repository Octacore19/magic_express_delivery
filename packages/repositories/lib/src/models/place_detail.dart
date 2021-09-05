import 'package:equatable/equatable.dart';
import 'package:services/services.dart';

class PlaceDetail extends Equatable {
  const PlaceDetail._({
    required this.name,
    required this.address,
    required this.longitude,
    required this.latitude,
  });

  factory PlaceDetail.empty() {
    return PlaceDetail._(
      name: '',
      address: '',
      longitude: 0,
      latitude: 0,
    );
  }

  factory PlaceDetail.fromResponse(PlaceDetailResponse response) {
    return PlaceDetail._(
      name: response.name ?? '',
      address: response.address ?? '',
      longitude: response.geometry?.location.longitude ?? 0,
      latitude: response.geometry?.location.latitude ?? 0,
    );
  }

  final String name;
  final String address;
  final double longitude;
  final double latitude;

  bool get empty => this == PlaceDetail.empty();

  bool get notEmpty => this == PlaceDetail.empty();

  @override
  String toString() {
    return '$runtimeType('
        'name: $name, '
        'address: $address, '
        'longitude: $longitude, '
        'latitude: $latitude'
        ')';
  }

  @override
  List<Object?> get props => [name, address, longitude, latitude];
}
