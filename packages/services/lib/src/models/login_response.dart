class LoginResponse {
  final _User? user;

  LoginResponse(this.user);

  LoginResponse.fromJson(Map<String, dynamic> json)
      : user = _User.fromJson(json['user']);

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

  _User({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.role,
  });

  _User.fromJson(Map<String, dynamic> json)
      : firstName = json['first_name'],
        lastName = json['last_name'],
        phoneNumber = json['phone_number'],
        email = json['email'],
        role = json['role'];

  @override
  String toString() {
    return '$runtimeType(firstName: $firstName, '
        'lastName: $lastName, '
        'phoneNumber: $phoneNumber, '
        'email: $email, '
        'role: $role)';
  }
}
