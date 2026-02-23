import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_pos_system_app/model/category_model.dart';
import 'package:laundry_pos_system_app/providers/service_provider.dart';
import '../services/service_api.dart';


// Category State
class CategoryState {
  final bool isLoading;
  final String? error;
  final List<ServiceCategory> categories;
  final ServiceCategory? selectedCategory;

  CategoryState({
    this.isLoading = false,
    this.error,
    this.categories = const [],
    this.selectedCategory,
  });

  CategoryState copyWith({
    bool? isLoading,
    String? error,
    List<ServiceCategory>? categories,
    ServiceCategory? selectedCategory,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

// Category Notifier
class CategoryNotifier extends StateNotifier<CategoryState> {
  final ServiceApi _serviceApi;

  CategoryNotifier(this._serviceApi) : super(CategoryState());

  // Load categories from API
  Future<void> loadCategories() async {
    // Don't load if already loaded or loading
    if (state.categories.isNotEmpty || state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      print('Loading categories from API...');
      final response = await _serviceApi.getServiceCategories();
      
      // Filter only active categories (status = 1)
      final activeCategories = response.data
          .where((category) => category.status == 1)
          .toList();

      print('Loaded ${activeCategories.length} active categories');

      state = state.copyWith(
        isLoading: false,
        categories: activeCategories,
        error: null,
      );
    } catch (e) {
      print('Error loading categories: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  // Select a category
  void selectCategory(ServiceCategory? category) {
    state = state.copyWith(selectedCategory: category);
  }

  // Clear selected category
  void clearSelectedCategory() {
    state = state.copyWith(selectedCategory: null);
  }

  // Get category by ID
  ServiceCategory? getCategoryById(int id) {
    try {
      return state.categories.firstWhere((cat) => cat.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get category by name
  ServiceCategory? getCategoryByName(String name) {
    try {
      return state.categories.firstWhere(
        (cat) => cat.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  // Refresh categories
  Future<void> refreshCategories() async {
    state = state.copyWith(categories: []);
    await loadCategories();
  }
}

// Providers
final categoryProvider = StateNotifierProvider<CategoryNotifier, CategoryState>((ref) {
  return CategoryNotifier(ref.read(serviceApiProvider));
});

// Simple provider for just the list of category names
final categoryNamesProvider = Provider<List<String>>((ref) {
  final categories = ref.watch(categoryProvider).categories;
  return categories.map((cat) => cat.name).toList();
});