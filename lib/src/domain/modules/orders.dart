import 'package:dartz/dartz.dart';
import 'package:magic_express_delivery/src/index.dart';

abstract class IOrdersService {
  Future<BaseResponse> createOrder(Map<String, dynamic> data);
}
abstract class IOrdersRepo {
  Future<Either<Failure, dynamic>> createErrandOrders(ErrandModel data);
  Future<Either<Failure, dynamic>> createDeliveryOrder(DeliveryModel data);
}