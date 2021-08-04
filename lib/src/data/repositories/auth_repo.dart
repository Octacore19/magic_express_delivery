/*
import 'package:dartz/dartz.dart';
import 'package:magic_express_delivery/src/index.dart';

class AuthRepo implements IAuthRepo {
  final IAuthService _service;

  AuthRepo(this._service);

  @override
  Future<Either<Failure, User>> loginUser(String email, String password) async {
    try {
      final data = {
        'email': email,
        'password': password,
      };
      final response = await _service.loginUser(data);
      if (response.success) {
        final user = LoginResponse.fromJson(response.data).user;
        if (user != null) {
          return Right(LoginResponse.toUser(user));
        }
        return Left(AuthFailure());
      }
      return Left(AuthFailure(message: response.message!));
    } on ServerException {
      return Left(ServerFailure(serverMessage: 'Unexpected error occurred!'));
    }
  }

  @override
  Future<Either<Failure, String>> registerUser(
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String password,
      String confirmPassword) async {
    try {
      final data = {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'role_id': 3,
        'phone_number': phoneNumber,
        'password': password,
        'password_confirmation': confirmPassword,
      };
      final response = await _service.registerUser(data);
      if (response.success) {
        if (response.message != null) {
          return Right(response.message!);
        }
        return Left(AuthFailure());
      }
      return Left(AuthFailure(message: response.message!));
    } on ServerException {
      return Left(ServerFailure(serverMessage: 'Unexpected error occurred'));
    }
  }
}
*/
