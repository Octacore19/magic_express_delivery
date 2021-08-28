class PlaceDetailResponse {
  PlaceDetailResponse.fromJson(Map<String, dynamic> json)
      : address = json['formatted_address'],
        name = json['name'],
        geometry = GeometryResponse.fromJson(json['geometry']);

  String? address;
  String? name;
  GeometryResponse? geometry;

  @override
  String toString() {
    return '$runtimeType(address: $address, name: $name, geometry: $geometry)';
  }
}

class GeometryResponse {
  GeometryResponse.fromJson(Map<String, dynamic> json)
      : location = LocationResponse.fromJson(json['location']);

  LocationResponse location;

  @override
  String toString() {
    return '$runtimeType(location: $location)';
  }
}

class LocationResponse {
  LocationResponse.fromJson(Map<String, dynamic> json)
      : latitude = json['lat'],
        longitude = json['lng'];

  double? latitude;
  double? longitude;

  @override
  String toString() {
    return '$runtimeType(longitude: $longitude, latitude: $latitude)';
  }
}
