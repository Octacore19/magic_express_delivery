import 'package:magic_express_delivery/src/index.dart';

class User extends BaseModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String role;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.role,
  });

  @override
  List<Object> get props => [firstName, lastName, email, phoneNumber, role];
}
