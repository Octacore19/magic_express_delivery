class LoginResponse {
  final _User? user;
  final String? paystackKey;

  LoginResponse.fromJson(Map<String, dynamic> json)
      : user = _User.fromJson(json['user']),
        paystackKey = json['public_key'];

  @override
  String toString() {
    return '$runtimeType(user: $user)';
  }
}

class _User {
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? email;
  final String? role;
  final bool? isVerified;

  _User({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.role,
    this.isVerified,
  });

  _User.fromJson(Map<String, dynamic> json)
      : firstName = json['first_name'],
        lastName = json['last_name'],
        phoneNumber = json['phone_number'],
        email = json['email'],
        role = json['role'],
        isVerified = json['is_verified'];

  @override
  String toString() {
    return '$runtimeType(firstName: $firstName, '
        'lastName: $lastName, '
        'phoneNumber: $phoneNumber, '
        'email: $email, '
        'isVerified: $isVerified, '
        'role: $role)';
  }
}
