class Customer {
  final int? id; // nullable because when creating, id is not sent
  final String name;
  final String type;
  final String mobileNo;
  final String whatsappNo;
  final String email;
  final String emirates;
  final String area;
  final String apartmentNumber;
  final String buildingName;
  final String mapLocation;
  final String taxNumber;
  final String address;
  final int status;

  Customer({
    this.id,
    required this.name,
    required this.type,
    required this.mobileNo,
    required this.whatsappNo,
    required this.email,
    required this.emirates,
    required this.area,
    required this.apartmentNumber,
    required this.buildingName,
    required this.mapLocation,
    required this.taxNumber,
    required this.address,
    required this.status,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'] ?? "",
      type: json['type'] ?? "",
      mobileNo: json['mobile_no'] ?? "",
      whatsappNo: json['whatsapp_no'] ?? "",
      email: json['email'] ?? "",
      emirates: json['emirates'] ?? "",
      area: json['area'] ?? "",
      apartmentNumber: json['apartment_number'] ?? "",
      buildingName: json['building_name'] ?? "",
      mapLocation: json['map_location'] ?? "",
      taxNumber: json['tax_number'] ?? "",
      address: json['address'] ?? "",
      status: json['status'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "type": type,
      "mobile_no": mobileNo,
      "whatsapp_no": whatsappNo,
      "email": email,
      "emirates": emirates,
      "area": area,
      "apartment_number": apartmentNumber,
      "building_name": buildingName,
      "map_location": mapLocation,
      "tax_number": taxNumber,
      "address": address,
      "status": status,
    };
  }
}