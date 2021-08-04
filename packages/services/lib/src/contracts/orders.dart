import 'package:services/src/models/models.dart';

abstract class IOrdersService {
  Future<BaseResponse> createOrder(Map<String, dynamic> data);
}