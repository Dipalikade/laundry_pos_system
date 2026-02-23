import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/customer_service.dart';
import '../services/dio_client.dart';
import '../model/customer_model.dart';

final customerServiceProvider = Provider<CustomerService>((ref) {
  final dio = ref.read(dioProvider);
  return CustomerService(dio);
});

class CustomerNotifier extends StateNotifier<AsyncValue<String?>> {
  final CustomerService service;

  CustomerNotifier(this.service) : super(const AsyncData(null));

  Future<void> addCustomer(Customer customer) async {
    state = const AsyncLoading();

    try {
      final message = await service.createCustomer(customer);
      state = AsyncData(message);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final customerProvider =
    StateNotifierProvider<CustomerNotifier, AsyncValue<String?>>((ref) {
      final service = ref.read(customerServiceProvider);
      return CustomerNotifier(service);
    });

final customersListProvider =
FutureProvider.family<List<Customer>, String>((ref, search) async {
  final service = ref.read(customerServiceProvider);
  return service.fetchCustomers(search: search, limit: 1000);
});
