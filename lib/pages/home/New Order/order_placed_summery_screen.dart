import 'package:flutter/material.dart';
import '../../../model/card_item_model.dart';
import '../../../model/customer_model.dart';
import 'order_placed_sucessfuly_screen.dart';

class OrderPlacedSummeryScreen extends StatefulWidget {
  final Customer customer;
  final List<CartItem> cartItems;
  final double discountPercentage;

  const OrderPlacedSummeryScreen({
    super.key,
    required this.customer,
    required this.cartItems,
    required this.discountPercentage,
  });

  @override
  State<OrderPlacedSummeryScreen> createState() =>
      _OrderPlacedSummeryScreenState();
}

class _OrderPlacedSummeryScreenState extends State<OrderPlacedSummeryScreen> {
  late List<CartItem> localCart;
  late double discountPercentage;

  @override
  void initState() {
    super.initState();
    localCart = List.from(widget.cartItems);
    discountPercentage = widget.discountPercentage;
  }

  void increaseQty(int index) {
    setState(() {
      localCart[index].quantity++;
    });
  }

  void decreaseQty(int index) {
    if (localCart[index].quantity > 1) {
      setState(() {
        localCart[index].quantity--;
      });
    }
  }

  void deleteItem(int index) {
    setState(() {
      localCart.removeAt(index);
    });
  }

  double getSubTotal() {
    double total = 0;
    for (var item in localCart) {
      total += item.price * item.quantity;
    }
    return total;
  }

  double getDiscountAmount() {
    return getSubTotal() * (discountPercentage / 100);
  }

  double getTotalAmount() {
    return getSubTotal() - getDiscountAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: Column(
        children: [
          /// 🔵 TOP BLUE HEADER
          Container(
            height: 140,
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
            decoration: const BoxDecoration(
              color: Color(0xFF3F6CC9),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Create Order",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          /// 🧾 CUSTOMER CARD
          Transform.translate(
            offset: const Offset(0, -40),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.grey.shade200,
                      child: Text(
                        widget.customer.name[0],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.customer.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(widget.customer.phone),
                          const SizedBox(height: 4),
                          Text(
                            widget.customer.address,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// 🛒 CART LIST
          Expanded(
            child: localCart.isEmpty
                ? const Center(child: Text("No items in cart"))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: localCart.length,
                    itemBuilder: (context, index) {
                      final item = localCart[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDDE2F4),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item.serviceType,
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "₹ ${item.price}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                _qtyButton(
                                  icon: Icons.remove,
                                  onTap: () => decreaseQty(index),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Text(
                                    item.quantity.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                _qtyButton(
                                  icon: Icons.add,
                                  onTap: () => increaseQty(index),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () => deleteItem(index),
                                  child: const Icon(
                                    Icons.delete_outline,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          /// TOTAL AMOUNT
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Amount",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "₹ ${getTotalAmount().toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          _buildSummary(),
          const SizedBox(height: 16),

          /// BUTTONS
          /// BOTTOM BUTTONS
          Padding(
            padding: EdgeInsetsGeometry.only(bottom: 30),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Color(0xFFCDD2E1)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Place order logic
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderSuccessScreen(
                              customerName: widget.customer.name,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4845D2),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Place Order",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xffEDE7F6),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          _SummaryRow("SubTotal", "₹ ${getSubTotal().toStringAsFixed(2)}"),
          _SummaryRow(
            "Discount (${discountPercentage.toStringAsFixed(0)}%)",
            "- ₹ ${getDiscountAmount().toStringAsFixed(2)}",
          ),
          _SummaryRow("Total", "₹ ${getTotalAmount().toStringAsFixed(2)}"),
        ],
      ),
    );
  }

  Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28,
        width: 28,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String title;
  final String value;

  const _SummaryRow(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
