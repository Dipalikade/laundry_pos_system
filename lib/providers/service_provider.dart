import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_pos_system_app/model/service_model.dart';
import '../services/service_api.dart';

// Service State
class ServiceState {
  final bool isLoading;
  final String? error;
  final List<ServiceItem> services;
  final PaginationInfo? pagination;
  final int currentPage;
  final String? searchQuery;
  final String? selectedCategory;
  final bool isSearching;

  ServiceState({
    this.isLoading = false,
    this.error,
    this.services = const [],
    this.pagination,
    this.currentPage = 1,
    this.searchQuery,
    this.selectedCategory,
    this.isSearching = false,
  });

  ServiceState copyWith({
    bool? isLoading,
    String? error,
    List<ServiceItem>? services,
    PaginationInfo? pagination,
    int? currentPage,
    String? searchQuery,
    String? selectedCategory,
    bool? isSearching,
  }) {
    return ServiceState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      services: services ?? this.services,
      pagination: pagination ?? this.pagination,
      currentPage: currentPage ?? this.currentPage,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}

// Service Notifier
class ServiceNotifier extends StateNotifier<ServiceState> {
  final ServiceApi _serviceApi;
  Timer? _debounceTimer;

  ServiceNotifier(this._serviceApi) : super(ServiceState());

  Future<void> loadServices({
    int page = 1,
    String? search,
    String? category,
    bool refresh = false,
  }) async {
    // Don't load if already loading
    if (state.isLoading) return;

    if (refresh) {
      state = state.copyWith(
        isLoading: true,
        error: null,
        services: [],
        currentPage: 1,
        searchQuery: search,
        selectedCategory: category,
        isSearching: search != null && search.isNotEmpty,
      );
    } else {
      state = state.copyWith(
        isLoading: true, 
        error: null,
        isSearching: search != null && search.isNotEmpty,
      );
    }

    try {
      print('Loading services - Page: $page, Search: $search, Category: $category');
      
      final response = await _serviceApi.getServiceList(
        page: page,
        limit: 10,
        search: search ?? state.searchQuery,
        category: category ?? state.selectedCategory,
      );

      final newServices = refresh 
          ? response.data 
          : [...state.services, ...response.data];

      print('Loaded ${response.data.length} services, Total: ${response.pagination.total}');

      state = state.copyWith(
        isLoading: false,
        services: newServices,
        pagination: response.pagination,
        currentPage: page,
        searchQuery: search ?? state.searchQuery,
        selectedCategory: category ?? state.selectedCategory,
        error: null,
        isSearching: false,
      );
    } catch (e) {
      print('Error loading services: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString().replaceAll('Exception: ', ''),
        isSearching: false,
      );
    }
  }

  // Search with debounce
  void searchServices(String query) {
    // Cancel previous timer
    _debounceTimer?.cancel();
    
    // Update search query in state
    state = state.copyWith(searchQuery: query);
    
    if (query.isEmpty) {
      // If search is empty, load all services
      loadServices(page: 1, search: '', refresh: true);
      return;
    }

    // Set searching state
    state = state.copyWith(isSearching: true);

    // Debounce search - wait 500ms after user stops typing
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      loadServices(page: 1, search: query, refresh: true);
    });
  }

  // Clear search
  void clearSearch() {
    _debounceTimer?.cancel();
    _searchController?.clear();
    state = state.copyWith(searchQuery: null, isSearching: false);
    loadServices(page: 1, search: '', refresh: true);
  }

  // Add reference to search controller
  TextEditingController? _searchController;
  
  void setSearchController(TextEditingController controller) {
    _searchController = controller;
  }

  void filterByCategory(String category) {
    print('Filtering by category: $category');
    state = state.copyWith(selectedCategory: category.isEmpty ? null : category);
    loadServices(page: 1, category: category, refresh: true);
  }

  void loadNextPage() {
    if (state.pagination?.hasNextPage == true && !state.isLoading) {
      loadServices(page: state.currentPage + 1);
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}

// Providers
final serviceApiProvider = Provider((ref) => ServiceApi());

final serviceProvider = StateNotifierProvider<ServiceNotifier, ServiceState>((ref) {
  return ServiceNotifier(ref.read(serviceApiProvider));
});