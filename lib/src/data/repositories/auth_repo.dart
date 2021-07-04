import 'package:dartz/dartz.dart';
import 'package:magic_express_delivery/src/index.dart';

class AuthRepo implements IAuthRepo {
  final IAuthService _service;

  AuthRepo(this._service);

  @override
  Future<Either<Failure, User>> loginuser(String email, String password) async {
    try {
      final response = await _service.loginuser(email, password);
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
  Future<Either<Failure, String>> registerUser(String firstName, String lastName, String email,
      String phoneNumber, String password, String confirmPassword) async {
    try {
      final response = await _service.registerUser(
        firstName,
        lastName,
        email,
        phoneNumber,
        password,
        confirmPassword,
      );
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
