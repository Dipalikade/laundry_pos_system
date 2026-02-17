import 'package:flutter/material.dart';
import '../../../model/card_item_model.dart';
import '../../../model/customer_model.dart';
import 'order_placed_summery_screen.dart';

class AddToMyCartScreen extends StatefulWidget {
  final Customer customer;
  final List<CartItem> cartItems;

  const AddToMyCartScreen({
    super.key,
    required this.customer,
    required this.cartItems,
  });

  @override
  State<AddToMyCartScreen> createState() => _AddToMyCartScreenState();
}

class _AddToMyCartScreenState extends State<AddToMyCartScreen> {

  late List<CartItem> localCart;
  double discountPercentage = 0;

  @override
  void initState() {
    super.initState();
    localCart = List.from(widget.cartItems);
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

  double getTotalAmount() {
    double total = 0;

    for (var item in localCart) {
      total += item.price * item.quantity;
    }

    double discountAmount = total * (discountPercentage / 100);

    return total - discountAmount;
  }

  void _showDiscountDialog() {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add Discount",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),

                TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "e.g. 5 %",
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB8C6EA),
                        ),
                        onPressed: () {
                          setState(() {
                            discountPercentage =
                                double.tryParse(controller.text) ?? 0;
                          });

                          Navigator.pop(context); // close dialog

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderPlacedSummeryScreen(
                                    customer: widget.customer,
                                    cartItems: localCart,
                                    discountPercentage: discountPercentage,
                                  ),
                            ),
                          );
                        },
                        child: const Text("Add"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: Column(
          children: [
        
            /// 🔵 TOP BLUE HEADER
            Container(
              height: 140,
              padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
              decoration: const BoxDecoration(
                color: Color(0xFF3F6CC9),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
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
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.grey.shade200,
                        child: Text(
                          widget.customer.name[0],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(widget.customer.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(widget.customer.phone),
                            const SizedBox(height: 4),
                            Text(widget.customer.address,
                                style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        
            /// ➕ ADD SERVICE BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFB8C6EA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "+  Add Service Item",
                    style: TextStyle(
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
        
            const SizedBox(height: 10),
        
            /// 🛒 CART LIST
            Expanded(
              child: localCart.isEmpty
                  ? const Center(
                child: Text("No items in cart"),
              )
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
                      borderRadius:
                      BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(
                                    fontWeight:
                                    FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.serviceType,
                                style: const TextStyle(
                                    color: Colors.blue),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "₹ ${item.price}",
                                style: const TextStyle(
                                    fontWeight:
                                    FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            _qtyButton(
                                icon: Icons.remove,
                                onTap: () =>
                                    decreaseQty(index)),
                            Container(
                              padding:
                              const EdgeInsets.symmetric(
                                  horizontal: 10),
                              child: Text(
                                item.quantity.toString(),
                                style: const TextStyle(
                                    fontWeight:
                                    FontWeight.bold),
                              ),
                            ),
                            _qtyButton(
                                icon: Icons.add,
                                onTap: () =>
                                    increaseQty(index)),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () =>
                                  deleteItem(index),
                              child: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Amount",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
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
        
            const SizedBox(height: 10),
        
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: GestureDetector(
                  onTap: _showDiscountDialog,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFB8C6EA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Add Discount",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _qtyButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
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