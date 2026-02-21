import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../model/driver_model.dart';
import '../services/dio_client.dart';


final driversProvider = FutureProvider<List<DriverModel>>((ref) async {
  final dio = ref.read(dioProvider);   // ✅ get dio from provider

  try {
    final response = await dio.get("employees/list");

    final data = response.data;

    if (data["success"] == true) {
      final List driversJson = data["data"];

      return driversJson
          .where((e) => e["role"] == "Driver" && e["status"] == 1)
          .map((e) => DriverModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Failed to load drivers");
    }
  } on DioException catch (e) {
    throw Exception(e.message);
  }
});