/*
import 'package:dio/dio.dart';
import 'package:magic_express_delivery/src/index.dart';

class OrdersService implements IOrdersService {
  final ApiProvider _provider;

  OrdersService(this._provider);

  @override
  Future<BaseResponse> createOrder(Map<String, dynamic> data) async {
    final baseResponse = await _provider.dioInstance.post(
      ApiEndpoints.CREATE_ORDER,
      data: FormData.fromMap(data),
    );
    return BaseResponse.fromJson(baseResponse.data);
  }
}
*/
