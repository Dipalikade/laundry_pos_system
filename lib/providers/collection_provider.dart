import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../model/collection_model.dart';
import '../services/dio_client.dart';

/// =============================
/// FETCH COLLECTION LIST
/// =============================
final collectionsProvider =
FutureProvider<List<CollectionModel>>((ref) async {
  final dio = ref.read(dioProvider);

  try {
    final response = await dio.get("collections/list");

    final data = response.data;

    if (data["success"] == true) {
      final List list = data["data"];

      return list
          .map((e) => CollectionModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Failed to load collections");
    }
  } on DioException catch (e) {
    throw Exception(e.message);
  }
});


/// =============================
/// DELETE CONTROLLER
/// =============================
final collectionControllerProvider =
Provider((ref) => CollectionController(ref));

class CollectionController {
  final Ref ref;

  CollectionController(this.ref);

  Future<void> deleteCollection(int id) async {
    final dio = ref.read(dioProvider);

    final response =
    await dio.delete("collections/delete/$id");

    if (response.data["success"] == true) {
      // Refresh the list after delete
      ref.invalidate(collectionsProvider);
    } else {
      throw Exception(response.data["message"]);
    }
  }
}