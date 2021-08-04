import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:services/src/commons/commons.dart';
import 'package:services/src/contracts/orders.dart';
import 'package:services/src/models/models.dart';

class OrdersImpl implements IOrdersService {
  final Dio _dio;

  OrdersImpl(this._dio);

  @override
  Future<BaseResponse> createOrder(Map<String, dynamic> data) async {
    final baseResponse = await _dio.post(
      ApiEndpoints.CREATE_ORDER,
      data: FormData.fromMap(data),
    );
    final response = BaseResponse.fromJson(baseResponse.data);
    log('Orders service response: $response');
    return response;
  }
}
