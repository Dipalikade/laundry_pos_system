class EmiratesModel {
  final int id;
  final String emirate;
  final String code;
  final String country;
  final int status;
  final String createdAt;
  final String updatedAt;

  EmiratesModel({
    required this.id,
    required this.emirate,
    required this.code,
    required this.country,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EmiratesModel.fromJson(Map<String, dynamic> json) {
    return EmiratesModel(
      id: json['id'],
      emirate: json['emirate'],
      code: json['code'],
      country: json['country'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}