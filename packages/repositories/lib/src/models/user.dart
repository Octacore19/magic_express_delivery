import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.firstName,
    this.lastName,
    required this.email,
    required this.phoneNumber,
    this.role,
    this.paystackKey = '',
    this.isVerified = false,
  });

  final String? firstName;
  final String? lastName;
  final String email;
  final String phoneNumber;
  final String? role;
  final String paystackKey;
  final bool isVerified;

  static const empty = User(email: '', phoneNumber: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  factory User.fromSerializedJson(Map<String, dynamic> json) {
    String t = json['p'] ?? '';
    List<int> value = t.isNotEmpty ? List.from(jsonDecode(t)) : [];
    String pKey = value.isNotEmpty ? utf8.decode(value) : '';
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      role: json['role'],
      paystackKey: pKey,
      isVerified: json['isVerified']
    );
  }

  String toSerializedJson() {
    final p = utf8.encode(paystackKey);
    final json = '{'
        '"firstName":"${this.firstName}",'
        '"lastName":"${this.lastName}",'
        '"email":"${this.email}",'
        '"phoneNumber":"${this.phoneNumber}",'
        '"p":"$p",'
        '"isVerified":"$isVerified",'
        '"role": "${this.role}"'
        '}';
    return json;
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        phoneNumber,
        role,
        paystackKey,
      ];
}
