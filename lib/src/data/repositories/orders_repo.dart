/*
import 'package:dartz/dartz.dart';
import 'package:magic_express_delivery/src/index.dart';

class OrdersRepo implements IOrdersRepo {
  final IOrdersService _ordersService;

  OrdersRepo(this._ordersService);

  @override
  Future<Either<Failure, dynamic>> createDeliveryOrder(DeliveryModel data) async {
    try {
      final response = await _ordersService.createOrder(DeliveryModel.toJson(data));
      if (response.success) {
        return Right(response.data);
      }
      return Left(ServerFailure(serverMessage: response.message!));
    } on ServerException {
      return Left(ServerFailure(serverMessage: 'Unexpected error occurred!'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> createErrandOrders(ErrandModel data) async {
    try {
      final response = await _ordersService.createOrder(ErrandModel.toJson(data));
      if (response.success) {
        return Right(response.data);
      }
      return Left(ServerFailure(serverMessage: response.message!));
    } on ServerException {
      return Left(ServerFailure(serverMessage: 'Unexpected error occurred!'));
    }
  }

}*/
