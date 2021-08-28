import 'package:equatable/equatable.dart';
import 'package:services/services.dart';

class PlaceDetail extends Equatable {
  const PlaceDetail({
    required this.name,
    required this.address,
    required this.longitude,
    required this.latitude,
  });

  const PlaceDetail.empty()
      : name = '',
        address = '',
        latitude = 0,
        longitude = 0;

  PlaceDetail.fromResponse(PlaceDetailResponse response)
      : name = response.name ?? '',
        address = response.address ?? '',
        latitude = response.geometry?.location.latitude ?? 0,
        longitude = response.geometry?.location.longitude ?? 0;

  final String name;
  final String address;
  final double longitude;
  final double latitude;

  bool get empty => this == PlaceDetail.empty();

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
