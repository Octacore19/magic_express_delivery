import 'package:services/src/models/models.dart';

abstract class IAuthenticationService {
  Future<DioResponse> loginUser(Map<String, String> data);

  Future<DioResponse> registerUser(Map<String, dynamic> data);
}