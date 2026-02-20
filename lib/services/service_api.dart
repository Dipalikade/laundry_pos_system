import 'package:dio/dio.dart';
import 'package:laundry_pos_system_app/model/category_model.dart';
import 'package:laundry_pos_system_app/model/service_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceApi {
  final Dio _dio;
  static const String baseUrl = 'https://slfuatbackend.1on1screen.com';

  ServiceApi() : _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  )) {
    // Add interceptor for auth token
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          print('API Request: ${options.method} ${options.path}');
          print('Query Params: ${options.queryParameters}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('API Response: ${response.statusCode}');
          return handler.next(response);
        },
        onError: (error, handler) {
          print('API Error: ${error.message}');
          return handler.next(error);
        },
      ),
    );
  }

  // Get service list with pagination and search
  Future<ServiceListResponse> getServiceList({
    int page = 1,
    int limit = 10,
    String? search,
    String? category,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
      };
      
      // Only add search if it's not null and not empty
      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }
      
      // Add category if selected and not 'All'
      if (category != null && category.isNotEmpty && category != 'All') {
        queryParams['category'] = category;
      }

      print('Calling API: /api/service_list/list with params: $queryParams');

      final response = await _dio.get(
        '/api/service_list/list',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return ServiceListResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load services: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Dio Error: ${e.message}');
      print('Response Data: ${e.response?.data}');
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to load services');
      } else {
        throw Exception('Network error. Please check your connection.');
      }
    } catch (e) {
      print('Unexpected Error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Get service categories
  Future<CategoryListResponse> getServiceCategories() async {
    try {
      print('Calling API: /api/service/service_categories/list');
      
      final response = await _dio.get('/api/service/service_categories/list');

      if (response.statusCode == 200) {
        print('Categories loaded: ${response.data['data']?.length} items');
        return CategoryListResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Categories Error: ${e.message}');
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to load categories');
      } else {
        throw Exception('Network error. Please check your connection.');
      }
    } catch (e) {
      print('Unexpected Categories Error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Get active categories only (status = 1)
  Future<List<ServiceCategory>> getActiveCategories() async {
    final response = await getServiceCategories();
    return response.data.where((category) => category.status == 1).toList();
  }

  // Fix image URL construction
  String getImageUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    if (path.startsWith('http')) return path;
    
    // Remove any duplicate 'uploads' in the path
    String cleanPath = path.replaceFirst('uploads/', '');
    return '$baseUrl/uploads/$cleanPath';
  }

  // Get service icon URL
  String getServiceIconUrl(String iconName) {
    if (iconName.isEmpty) return '';
    
    // Handle different icon name formats
    String cleanIcon = iconName.replaceFirst('uploads/', '');
    return '$baseUrl/uploads/$cleanIcon';
  }
}