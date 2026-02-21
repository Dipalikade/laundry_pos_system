import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../services/dio_client.dart';


final createCollectionProvider =
FutureProvider.family<Map<String, dynamic>, Map<String, dynamic>>(
        (ref, body) async {
      final dio = ref.read(dioProvider);

      try {
        final response = await dio.post(
          "collections/create",
          data: body,
        );

        return response.data;
      } on DioException catch (e) {
        throw Exception(e.response?.data["message"] ?? e.message);
      }
    });