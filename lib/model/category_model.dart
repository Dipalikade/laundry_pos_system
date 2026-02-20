class ServiceCategory {
  final int id;
  final String name;
  final String colorCode;
  final int status;
  final DateTime createdAt;

  ServiceCategory({
    required this.id,
    required this.name,
    required this.colorCode,
    required this.status,
    required this.createdAt,
  });

  factory ServiceCategory.fromJson(Map<String, dynamic> json) {
    return ServiceCategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      colorCode: json['color_code'] ?? '',
      status: json['status'] ?? 0,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color_code': colorCode,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class CategoryListResponse {
  final bool success;
  final List<ServiceCategory> data;

  CategoryListResponse({
    required this.success,
    required this.data,
  });

  factory CategoryListResponse.fromJson(Map<String, dynamic> json) {
    return CategoryListResponse(
      success: json['success'] ?? false,
      data: (json['data'] as List? ?? [])
          .map((e) => ServiceCategory.fromJson(e))
          .toList(),
    );
  }
}

