import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_pos_system_app/model/service_model.dart';
import 'package:laundry_pos_system_app/providers/category_provider.dart';
import 'package:laundry_pos_system_app/services/service_api.dart';
import 'package:laundry_pos_system_app/util/header.dart';
import '../../../model/card_item_model.dart';
import '../../../model/customer_model.dart';
import '../../../providers/service_provider.dart';
import 'add_to_my_cart_screen.dart';

class AddServiceItemScreen extends ConsumerStatefulWidget {
  final Customer customer;
  const AddServiceItemScreen({super.key, required this.customer});

  @override
  ConsumerState<AddServiceItemScreen> createState() =>
      _AddServiceItemScreenState();
}

class _AddServiceItemScreenState extends ConsumerState<AddServiceItemScreen> {
  List<CartItem> cartItems = [];
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadInitialServices();
    _scrollController.addListener(_onScroll);

    Future.microtask(() {
      ref.read(serviceProvider.notifier).setSearchController(_searchController);
    });

    Future.microtask(() {
      ref.read(categoryProvider.notifier).loadCategories();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadInitialServices() {
    Future.microtask(() {
      ref.read(serviceProvider.notifier).loadServices(refresh: true);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(serviceProvider.notifier).loadNextPage();
    }
  }

  void addToCart(String title, String serviceType, double price) {
    final existingIndex = cartItems.indexWhere(
      (item) => item.title == title && item.serviceType == serviceType,
    );

    if (existingIndex >= 0) {
      cartItems[existingIndex].quantity++;
    } else {
      cartItems.add(
        CartItem(
          title: title,
          serviceType: serviceType,
          price: price,
          quantity: 1,
        ),
      );
    }

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title added to cart'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final serviceState = ref.watch(serviceProvider);
    final categoryState = ref.watch(categoryProvider);
    final serviceApi = ref.read(serviceApiProvider);
    final serviceNotifier = ref.read(serviceProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: Column(
          children: [
            headerUi(title: "Add Service Item"),
            const SizedBox(height: 16),

            /// SEARCH + CART
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Search Item Here",
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color(0xFF2F66C8),
                          ),
                          border: InputBorder.none,
                          suffixIcon:
                              serviceState.searchQuery != null &&
                                  serviceState.searchQuery!.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    _searchController.clear();
                                    serviceNotifier.clearSearch();
                                  },
                                )
                              : null,
                        ),
                        onChanged: (value) {
                          serviceNotifier.searchServices(value);
                        },
                        onSubmitted: (value) {
                          serviceNotifier.loadServices(
                            page: 1,
                            search: value,
                            refresh: true,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  /// CART BUTTON WITH BADGE
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddToMyCartScreen(
                            customer: widget.customer,
                            cartItems: cartItems,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3F6CC9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          const Center(
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                            ),
                          ),
                          if (cartItems.isNotEmpty)
                            Positioned(
                              right: 5,
                              top: 5,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Text(
                                  '${cartItems.length}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Category Filter
            if (categoryState.categories.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 45,
                  child: categoryState.isLoading
                      ? const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                      : ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            // "All" chip
                            FilterChip(
                              label: Text(
                                'All',
                                style: TextStyle(
                                  color: categoryState.selectedCategory == null
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              selected: categoryState.selectedCategory == null,
                              selectedColor: const Color(0xFF2F66C8),
                              checkmarkColor: Colors.white,
                              onSelected: (_) {
                                ref
                                    .read(categoryProvider.notifier)
                                    .clearSelectedCategory();
                                serviceNotifier.filterByCategory('');
                              },
                            ),
                            const SizedBox(width: 8),

                            // Dynamic category chips
                            ...categoryState.categories.map((category) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: FilterChip(
                                  label: Text(category.name),
                                  selected:
                                      categoryState.selectedCategory?.id ==
                                      category.id,
                                  selectedColor: _getColorFromCode(
                                    category.colorCode,
                                  ),
                                  checkmarkColor: Colors.white,
                                  onSelected: (_) {
                                    ref
                                        .read(categoryProvider.notifier)
                                        .selectCategory(category);
                                    serviceNotifier.filterByCategory(
                                      category.name,
                                    );
                                  },
                                ),
                              );
                            }),
                          ],
                        ),
                ),
              ),

            const SizedBox(height: 20),

            /// Search Status Indicator
            if (serviceState.searchQuery != null &&
                serviceState.searchQuery!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Search results for "${serviceState.searchQuery}"',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF2F66C8),
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (serviceState.isSearching)
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                  ],
                ),
              ),

            /// Error Display
            if (serviceState.error != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error, color: Colors.red.shade700, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          serviceState.error!,
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            if (categoryState.error != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Text(
                  'Categories: ${categoryState.error}',
                  style: const TextStyle(color: Colors.orange, fontSize: 11),
                ),
              ),

            const SizedBox(height: 12),

            /// GRID
            Expanded(
              child: serviceState.isLoading && serviceState.services.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : serviceState.services.isEmpty
                  ? _buildEmptyState(serviceState)
                  : _buildGridView(serviceState, serviceApi),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(ServiceState serviceState) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            serviceState.searchQuery != null &&
                    serviceState.searchQuery!.isNotEmpty
                ? Icons.search_off
                : Icons.inventory_2_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            serviceState.searchQuery != null &&
                    serviceState.searchQuery!.isNotEmpty
                ? 'No items found for "${serviceState.searchQuery}"'
                : 'No services available',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
          if (serviceState.searchQuery != null &&
              serviceState.searchQuery!.isNotEmpty)
            TextButton(
              onPressed: () {
                _searchController.clear();
                ref.read(serviceProvider.notifier).clearSearch();
              },
              child: const Text('Clear Search'),
            ),
          if (serviceState.error != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ElevatedButton(
                onPressed: _loadInitialServices,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F66C8),
                ),
                child: const Text('Retry'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGridView(ServiceState serviceState, ServiceApi serviceApi) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        controller: _scrollController,
        itemCount:
            serviceState.services.length +
            (serviceState.pagination?.hasNextPage == true ? 1 : 0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          if (index >= serviceState.services.length) {
            return const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          }

          final item = serviceState.services[index];
          return ServiceItemCard(
            title: item.name,
            imageUrl: serviceApi.getServiceIconUrl(item.addIcon),
            serviceTypes: item.serviceTypes,
            onAdd: (serviceType, price) {
              addToCart(item.name, serviceType, price);
            },
          );
        },
      ),
    );
  }

  // Helper method to get color from code
  Color _getColorFromCode(String colorCode) {
    switch (colorCode) {
      case 'bg-primary':
        return const Color(0xFF2F66C8);
      case 'bg-danger':
        return Colors.red;
      case 'bg-warning':
        return Colors.orange;
      case 'bg-secondary':
        return Colors.grey;
      case 'cheese':
        return Colors.amber;
      default:
        return const Color(0xFF2F66C8);
    }
  }
}

/// SERVICE CARD
class ServiceItemCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final List<ServiceType> serviceTypes;
  final Function(String serviceType, double price) onAdd;

  const ServiceItemCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.serviceTypes,
    required this.onAdd,
  });

  void _showServiceOptions(BuildContext context) {
    if (serviceTypes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No service options available')),
      );
      return;
    }

    if (serviceTypes.length == 1) {
      // Single service type - add directly
      final service = serviceTypes.first;
      onAdd(service.type, double.parse(service.price));
      return;
    }

    // Multiple service types - show bottom sheet
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return _ServiceTypeBottomSheet(
          title: title,
          serviceTypes: serviceTypes,
          onAdd: onAdd,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showServiceOptions(context),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        print('Image error for $title: $error');
                        print('Failed URL: $imageUrl');

                        // Try alternative path by replacing 'uploads' with 'images'
                        final alternativeUrl = imageUrl.replaceFirst(
                          '/uploads/',
                          '/images/',
                        );

                        return Image.network(
                          alternativeUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            // If alternative also fails, show placeholder
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image_not_supported,
                                  size: 30,
                                  color: Colors.grey.shade400,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'No image',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                    )
                  : Icon(
                      Icons.image_not_supported,
                      size: 40,
                      color: Colors.grey.shade400,
                    ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (serviceTypes.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF2F66C8).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${serviceTypes.length} type${serviceTypes.length > 1 ? 's' : ''}',
                  style: TextStyle(
                    fontSize: 8,
                    color: const Color(0xFF2F66C8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Service Type Bottom Sheet
class _ServiceTypeBottomSheet extends StatefulWidget {
  final String title;
  final List<ServiceType> serviceTypes;
  final Function(String serviceType, double price) onAdd;

  const _ServiceTypeBottomSheet({
    required this.title,
    required this.serviceTypes,
    required this.onAdd,
  });

  @override
  State<_ServiceTypeBottomSheet> createState() =>
      _ServiceTypeBottomSheetState();
}

class _ServiceTypeBottomSheetState extends State<_ServiceTypeBottomSheet> {
  ServiceType? _selectedService;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select Service for ${widget.title}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Service Types List
          ...widget.serviceTypes.map((service) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedService = service;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _selectedService == service
                      ? const Color(0xFFF3F1FF)
                      : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _selectedService == service
                        ? const Color(0xFF4B4BD6)
                        : Colors.grey.shade300,
                  ),
                ),
                child: Row(
                  children: [
                    Radio<ServiceType>(
                      value: service,
                      groupValue: _selectedService,
                      activeColor: const Color(0xFF4B4BD6),
                      onChanged: (value) {
                        setState(() {
                          _selectedService = value;
                        });
                      },
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service.type,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'AED ${service.price}',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: 20),

          // Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4B4BD6),
                  ),
                  onPressed: _selectedService == null
                      ? null
                      : () {
                          widget.onAdd(
                            _selectedService!.type,
                            double.parse(_selectedService!.price),
                          );
                          Navigator.pop(context);
                        },
                  child: const Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
