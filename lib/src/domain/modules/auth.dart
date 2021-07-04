import 'package:dartz/dartz.dart';
import 'package:magic_express_delivery/src/index.dart';

abstract class IAuthService {
  Future<BaseResponse> loginuser(String email, String password);
  Future registerUser(
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String password,
    String confirmPassword,
  );
}

abstract class IAuthRepo {
  Future<Either<Failure, User>> loginuser(String email, String password);
  Future registerUser(
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String password,
    String confirmPassword,
  );
}
