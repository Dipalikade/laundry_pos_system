class DriverModel {
  final int id;
  final String firstName;
  final String lastName;
  final String mobileNo;

  DriverModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobileNo,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      mobileNo: json['mobile_no'],
    );
  }

  String get fullName => "$firstName $lastName";
}