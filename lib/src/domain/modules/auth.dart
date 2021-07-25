import 'package:dartz/dartz.dart';
import 'package:magic_express_delivery/src/index.dart';

abstract class IAuthService {
  Future<BaseResponse> loginUser(Map<String, String> data);
  Future<BaseResponse> registerUser(Map<String, dynamic> data);
}

abstract class IAuthRepo {
  Future<Either<Failure, User>> loginUser(String email, String password);
  Future<Either<Failure, String>> registerUser(
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String password,
    String confirmPassword,
  );
}
