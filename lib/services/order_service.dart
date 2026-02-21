import 'dart:convert';
import 'package:dio/dio.dart';
import '../model/order_model.dart';

class OrderService {
  final Dio _dio;

  OrderService(this._dio);

  Future<List<OrderModel>> fetchOrders() async {
    final response = await _dio.get(
      "/orders/list?page=1&limit=10",
    );

    final data = response.data;

    if (data["success"] == true) {
      final List orders = data["data"];
      return orders.map((e) => OrderModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load orders");
    }
  }
}