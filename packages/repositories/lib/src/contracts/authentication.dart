import 'dart:async';

import 'package:repositories/src/api/api.dart';
import 'package:repositories/src/models/models.dart';

abstract class IAuthRepo {

  Stream<AuthStatus> get status;

  Future<User> get currentUser;

  Future<void> loginUser(String email, String password);

  Future<void> registerUser(
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String password,
      String confirmPassword,
      );

  void logOut();

  void dispose();
}