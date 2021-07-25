class Location {
  final double? _latitude;
  final double? _longitude;
  final String? _address;
  final String? _timestamp;

  Location(double? lat, double? long, String? add, String? time)
      : _latitude = lat,
        _longitude = long,
        _address = add,
        _timestamp = time;

  static Map<String, dynamic> toJson(Location? loc) {
    return {
      'latitude': loc?._latitude,
      'longitude': loc?._longitude,
      'address': loc?._address,
      'time_stamp': loc?._timestamp,
    };
  }

  @override
  String toString() {
    return 'Location(latitude: $_latitude, longitude: $_longitude, address: $_address, timestamp: $_timestamp)';
  }
}