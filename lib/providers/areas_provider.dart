import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/area_model.dart';
import '../services/customer_service.dart';
import '../services/dio_client.dart';

final areaServiceProvider = Provider<CustomerService>((ref) {
  final dio = ref.read(dioProvider);
  return CustomerService(dio);
});

final areasProvider =
FutureProvider<List<AreaModel>>((ref) async {
  final service = ref.read(areaServiceProvider);
  return service.getAreas();
});