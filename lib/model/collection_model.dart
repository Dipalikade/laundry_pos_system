class CollectionModel {
  final int id;
  final String collectionCode;
  final String collectionType;
  final DateTime pickupDate;
  final String timeSlot;
  final String phoneNumber;
  final int driverId;
  final String status;
  final String comments;

  CollectionModel({
    required this.id,
    required this.collectionCode,
    required this.collectionType,
    required this.pickupDate,
    required this.timeSlot,
    required this.phoneNumber,
    required this.driverId,
    required this.status,
    required this.comments,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json["id"],
      collectionCode: json["collection_code"],
      collectionType: json["collection_type"],
      pickupDate: DateTime.parse(json["pickup_date"]),
      timeSlot: json["time_slot"],
      phoneNumber: json["phone_number"],
      driverId: json["driver_id"],
      status: json["status"],
      comments: json["comments"] ?? "",
    );
  }
}