import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/emirates_model.dart';
import '../services/customer_service.dart';
import '../services/dio_client.dart';

final customerServiceProvider = Provider<CustomerService>((ref) {
  final dio = ref.read(dioProvider);
  return CustomerService(dio);
});

final emiratesProvider = FutureProvider<List<EmiratesModel>>((ref) async {
  final service = ref.read(customerServiceProvider);
  return service.getEmirates();
});
