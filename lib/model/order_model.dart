class OrderModel {
  final String orderId;
  final String date;
  final String customerName;
  final String phone;
  final String address;
  final String status;
  final double subtotal;
  final double discount;
  final double total;

  OrderModel({
    required this.orderId,
    required this.date,
    required this.customerName,
    required this.phone,
    required this.address,
    required this.status,
    required this.subtotal,
    required this.discount,
    required this.total,
  });
}
