import 'package:dio/dio.dart';
import '../model/customer_model.dart';

class CustomerService {
  final Dio dio;

  CustomerService(this.dio);

  // 🔹 Create Customer
  Future<String> createCustomer(Customer customer) async {
    try {
      final response = await dio.post(
        "customers/create",
        data: customer.toJson(),
      );

      if (response.statusCode == 200 &&
          response.data["success"] == true) {
        return response.data["message"];
      } else {
        throw Exception(response.data["message"]);
      }
    } on DioException catch (e) {
      throw Exception(
          e.response?.data["message"] ?? "Something went wrong");
    }
  }

  // 🔹 Fetch Customers
  Future<List<Customer>> fetchCustomers({
    String search = "",
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await dio.get(
        "customers/list",
        queryParameters: {
          "search": search,
          "page": page,
          "limit": limit,
        },
      );

      if (response.statusCode == 200 &&
          response.data["success"] == true) {

        final List data = response.data["data"];

        return data.map((json) => Customer.fromJson(json)).toList();
      } else {
        throw Exception(response.data["message"]);
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Failed to fetch customers",
      );
    }
  }
}