class AreaModel {
  final int id;
  final String area;
  final String emirates;
  final String country;
  final int status;

  AreaModel({
    required this.id,
    required this.area,
    required this.emirates,
    required this.country,
    required this.status,
  });

  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(
      id: json["id"] ?? 0,
      area: json["area"] ?? "",
      emirates: json["emirates"] ?? "",
      country: json["country"] ?? "",
      status: json["status"] ?? 0,
    );
  }
}