class OrderModel {
  final int id;
  final String orderCode;
  final String customerName;
  final String driverName;
  final String orderStatus;
  final double grossTotal;
  final double paidAmount;
  final double pendingAmount;
  final String paymentStatus;
  final String orderDate;

  OrderModel({
    required this.id,
    required this.orderCode,
    required this.customerName,
    required this.driverName,
    required this.orderStatus,
    required this.grossTotal,
    required this.paidAmount,
    required this.pendingAmount,
    required this.paymentStatus,
    required this.orderDate,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      orderCode: json['order_code'] ?? '',
      customerName: json['customer_name'] ?? '',
      driverName: json['driver_name'] ?? '',
      orderStatus: json['order_status'] ?? '',
      grossTotal: double.parse(json['gross_total'].toString()),
      paidAmount: double.parse(json['paid_amount'].toString()),
      pendingAmount: double.parse(json['pending_amount'].toString()),
      paymentStatus: json['payment_status'] ?? '',
      orderDate: json['order_date'] ?? '',
    );
  }
}