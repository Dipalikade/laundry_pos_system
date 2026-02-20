class ServiceType {
  final String type;
  final String price;
  final String? image;

  ServiceType({
    required this.type,
    required this.price,
    this.image,
  });

  factory ServiceType.fromJson(Map<String, dynamic> json) {
    return ServiceType(
      type: json['type'] ?? '',
      price: json['price']?.toString() ?? '0',
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'price': price,
      'image': image,
    };
  }
}

class ServiceItem {
  final int id;
  final String name;
  final String addIcon;
  final String category;
  final int sortingOrder;
  final int sqfStatus;
  final int status;
  final DateTime createdAt;
  final List<ServiceType> serviceTypes;

  ServiceItem({
    required this.id,
    required this.name,
    required this.addIcon,
    required this.category,
    required this.sortingOrder,
    required this.sqfStatus,
    required this.status,
    required this.createdAt,
    required this.serviceTypes,
  });

  factory ServiceItem.fromJson(Map<String, dynamic> json) {
    return ServiceItem(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      addIcon: json['addIcon'] ?? '',
      category: json['category'] ?? '',
      sortingOrder: json['sorting_order'] ?? 0,
      sqfStatus: json['sqf_status'] ?? 0,
      status: json['status'] ?? 0,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      serviceTypes: (json['service_types'] as List? ?? [])
          .map((e) => ServiceType.fromJson(e))
          .toList(),
    );
  }

  // Get image URL
  String getImageUrl(String baseUrl) {
    if (addIcon.isEmpty) return '';
    return '$baseUrl/uploads/$addIcon';
  }
}

class PaginationInfo {
  final int page;
  final int limit;
  final int total;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPrevPage;

  PaginationInfo({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPrevPage,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) {
    return PaginationInfo(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
      totalPages: json['totalPages'] ?? 1,
      hasNextPage: json['hasNextPage'] ?? false,
      hasPrevPage: json['hasPrevPage'] ?? false,
    );
  }
}

class ServiceListResponse {
  final bool success;
  final List<ServiceItem> data;
  final PaginationInfo pagination;

  ServiceListResponse({
    required this.success,
    required this.data,
    required this.pagination,
  });

  factory ServiceListResponse.fromJson(Map<String, dynamic> json) {
    return ServiceListResponse(
      success: json['success'] ?? false,
      data: (json['data'] as List? ?? [])
          .map((e) => ServiceItem.fromJson(e))
          .toList(),
      pagination: PaginationInfo.fromJson(json['pagination'] ?? {}),
    );
  }
}