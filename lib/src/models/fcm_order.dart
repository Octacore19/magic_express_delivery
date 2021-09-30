import 'dart:convert';

import 'package:repositories/repositories.dart';

class FCMOrder extends Equatable {
  const FCMOrder._({
    required this.rider,
    required this.user,
    required this.trackingNumber,
  });

  factory FCMOrder.empty() {
    return FCMOrder._(
      rider: FCMUser.empty(),
      user: FCMUser.empty(),
      trackingNumber: '',
    );
  }

  factory FCMOrder.fromJson(Map<String, dynamic> json) {
    return FCMOrder._(
      rider: FCMUser.fromJson(jsonDecode(json['rider'])),
      user: FCMUser.fromJson(jsonDecode(json['user'])),
      trackingNumber: json['tracking_number'],
    );
  }

  final FCMUser rider;
  final FCMUser user;
  final String trackingNumber;

  @override
  List<Object?> get props => [
        rider,
        user,
        trackingNumber,
      ];
}

class FCMUser extends Equatable {
  const FCMUser._({
    required this.address,
    required this.email,
    required this.longitude,
    required this.latitude,
    required this.phoneNumber,
    required this.lastName,
    required this.firstName,
  });

  factory FCMUser.empty() {
    return FCMUser._(
      address: '',
      email: '',
      longitude: 0,
      latitude: 0,
      phoneNumber: '',
      lastName: '',
      firstName: '',
    );
  }

  factory FCMUser.fromJson(Map<String, dynamic> json) {
    return FCMUser._(
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      longitude: json['location_longitude'] ?? 0,
      latitude: json['location_latitude'] ?? 0,
      phoneNumber: json['phone_number'] ?? '',
      lastName: json['last_name'] ?? '',
      firstName: json['first_name'] ?? '',
    );
  }

  final String lastName;
  final String firstName;
  final String phoneNumber;
  final String email;
  final double latitude;
  final double longitude;
  final String address;

  @override
  List<Object?> get props => [
        lastName,
        firstName,
        phoneNumber,
        email,
        latitude,
        longitude,
        address,
      ];
}
