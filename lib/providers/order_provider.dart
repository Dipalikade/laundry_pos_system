import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../model/order_model.dart';
import '../services/dio_client.dart';
import '../services/order_service.dart';


final orderServiceProvider = Provider<OrderService>((ref) {
  final dio = ref.read(dioProvider);
  return OrderService(dio);
});

final ordersProvider = FutureProvider<List<OrderModel>>((ref) async {
  final service = ref.read(orderServiceProvider);
  return service.fetchOrders();
});