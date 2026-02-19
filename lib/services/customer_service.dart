import 'package:dio/dio.dart';
import '../model/area_model.dart';
import '../model/customer_model.dart';
import '../model/emirates_model.dart';

class CustomerService {
  final Dio dio;

  CustomerService(this.dio);

  // 🔹 Create Customer
  Future<String> createCustomer(Customer customer) async {
    try {
      final response = await dio.post(
        "/customers/create", // ✅ FIXED
        data: customer.toJson(),
      );

      final data = response.data;

      if (response.statusCode == 200 && data["success"] == true) {
        return data["message"] ?? "Customer created";
      } else {
        throw Exception(data["message"] ?? "Failed to create customer");
      }
    } on DioException catch (e) {
      final message =
          (e.response?.data is Map && e.response?.data["message"] != null)
          ? e.response?.data["message"]
          : "Something went wrong";

      throw Exception(message);
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
        "/customers/list", // ✅ FIXED
        queryParameters: {"search": search, "page": page, "limit": limit},
      );

      final data = response.data;

      if (response.statusCode == 200 && data["success"] == true) {
        final List list = data["data"] ?? [];
        return list.map((json) => Customer.fromJson(json)).toList();
      } else {
        throw Exception(data["message"] ?? "Failed to fetch customers");
      }
    } on DioException catch (e) {
      final message =
          (e.response?.data is Map && e.response?.data["message"] != null)
          ? e.response?.data["message"]
          : "Failed to fetch customers";

      throw Exception(message);
    }
  }

  // 🔹 Fetch Emirates
  Future<List<EmiratesModel>> getEmirates() async {
    try {
      final response = await dio.get(
        "/location_management/emirates/list",
      ); // ✅ FIXED

      final responseData = response.data;

      if (response.statusCode == 200 && responseData["success"] == true) {
        final List list = responseData["data"] ?? [];

        return list.map((e) => EmiratesModel.fromJson(e)).toList();
      } else {
        throw Exception(responseData["message"] ?? "Failed to load emirates");
      }
    } on DioException catch (e) {
      final message =
          (e.response?.data is Map && e.response?.data["message"] != null)
          ? e.response?.data["message"]
          : "Failed to load emirates";

      throw Exception(message);
    }
  }

  // 🔹 Fetch Areas
  Future<List<AreaModel>> getAreas({int page = 1, int limit = 10}) async {
    try {
      final response = await dio.get(
        "/areas/list",
        queryParameters: {"page": page, "limit": limit},
      );

      final responseData = response.data;

      if (response.statusCode == 200 && responseData["success"] == true) {
        final List list = responseData["data"] ?? [];

        return list.map((e) => AreaModel.fromJson(e)).toList();
      } else {
        throw Exception(responseData["message"] ?? "Failed to load areas");
      }
    } on DioException catch (e) {
      final message =
          (e.response?.data is Map && e.response?.data["message"] != null)
          ? e.response?.data["message"]
          : "Failed to load areas";

      throw Exception(message);
    }
  }
}
