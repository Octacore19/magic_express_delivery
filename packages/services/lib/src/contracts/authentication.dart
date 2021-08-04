import 'package:services/src/models/models.dart';

abstract class IAuthenticationService {
  Future<BaseResponse> loginUser(Map<String, String> data);

  Future<BaseResponse> registerUser(Map<String, dynamic> data);
}