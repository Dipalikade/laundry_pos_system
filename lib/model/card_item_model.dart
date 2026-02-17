class CartItem {
  final String title;
  final String serviceType;
  final double price;
  int quantity;

  CartItem({
    required this.title,
    required this.serviceType,
    required this.price,
    this.quantity = 1,
  });
}