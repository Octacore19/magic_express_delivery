import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.firstName,
    this.lastName,
    required this.email,
    required this.phoneNumber,
    this.role,
  });

  final String? firstName;
  final String? lastName;
  final String email;
  final String phoneNumber;
  final String? role;

  static const empty = User(email: '', phoneNumber: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  factory User.fromSerializedJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      role: json['role'],
    );
  }

  String toSerializedJson() {
    final json =
        '{'
        '"firstName":"${this.firstName}",'
        '"lastName":"${this.lastName}",'
        '"email":"${this.email}",'
        '"phoneNumber":"${this.phoneNumber}",'
        '"role": "${this.role}"'
        '}';
    return json;
  }

  @override
  List<Object?> get props => [firstName, lastName, email, phoneNumber, role];
}
