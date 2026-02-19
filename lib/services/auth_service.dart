import 'package:dio/dio.dart';
import 'package:laundry_pos_system_app/model/user_model.dart';
import 'package:laundry_pos_system_app/services/apibaseurl.dart';

class AuthService {
 final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));

  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      } else {
        throw Exception('Login failed');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // Server responded with error
        throw Exception(e.response?.data['message'] ?? 'Login failed');
      } else {
        // Network error
        throw Exception('Network error. Please check your connection.');
      }
    } catch (e) {
      throw Exception('An unexpected error occurred');
    }
  }
}