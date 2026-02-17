import 'package:flutter/material.dart';
import 'package:laundry_pos_system_app/pages/home/New%20Order/transaction_history.dart';
import '../../../model/customer_model.dart';
import 'add_service_item_screen.dart';
import 'order_history.dart';

class CreateOrderScreen extends StatefulWidget {
  final Customer customer;

  const CreateOrderScreen({super.key, required this.customer});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  @override
  Widget build(BuildContext context) {
    String initials = widget.customer.name
        .trim()
        .split(" ")
        .map((e) => e[0])
        .take(2)
        .join()
        .toUpperCase();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      body: Stack(
        children: [
          /// 🔵 Blue Header
          Container(
            height: 190,
            decoration: const BoxDecoration(
              color: Color(0xFF3F6CC9),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            ),
            padding: const EdgeInsets.only(
              top: 45,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Create Order",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.add, size: 16, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            "Add Customer",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.notifications_none, color: Colors.white),
                  ],
                ),
              ],
            ),
          ),

          /// 🔽 Scrollable Body
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 130),

                /// 👤 Customer Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _customerCard(initials),
                ),

                const SizedBox(height: 20),

                /// 📊 Summary Cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _summaryCard(
                        "Total Amount",
                        "AED 44,888.84",
                        Icons.inventory_2,
                      ),
                      _summaryCard("Total Paid", "AED 27,654.42", Icons.wallet),
                      _summaryCard(
                        "Outstanding",
                        "AED 17,234.42",
                        Icons.local_shipping,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// ➕ Add Service Item
                _mainButton(
                  title: "Add Service Item",
                  icon: Icons.add,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            AddServiceItemScreen(customer: widget.customer),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 12),

                /// 💸 Apply Discount
                _mainButton(title: "Apply Discount", onTap: () {}),

                const SizedBox(height: 170),

                _historyButton(
                  "Order History",
                  isFilled: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OrderHistoryScreen(customer: widget.customer),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 10),

                _historyButton(
                  "Transaction History",
                  isFilled: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TransactionHistoryScreen(customer: widget.customer),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= COMPONENTS =================
  Widget _customerCard(String initials) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: const Color(0xFFE6ECFA),
            child: Text(
              initials,
              style: const TextStyle(
                color: Color(0xFF3F6CC9),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person,size: 15,color: Colors.grey,),
                    const SizedBox(width: 8,),
                    Text(
                      widget.customer.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                Row(
                  children: [
                    const Icon(Icons.person_add_alt,size: 15,color: Colors.grey),
                    const SizedBox(width: 8,),
                    Text(
                      widget.customer.type ?? "Individual",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(Icons.phone,size: 15,color: Colors.grey),
                    const SizedBox(width: 8,),
                    Text(widget.customer.phone,
                        style: const TextStyle(fontSize: 12)),
                  ],
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    const Icon(Icons.email,size: 15,color: Colors.grey),
                    const SizedBox(width: 8,),
                    Text(widget.customer.email ?? "",
                        style: const TextStyle(fontSize: 12)),
                  ],
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    const Icon(Icons.location_on,size: 15,color: Colors.grey),
                    const SizedBox(width: 8,),
                    Text(widget.customer.address ?? "",
                        style: const TextStyle(fontSize: 12)),
                  ],
                )

              ],
            ),
          ),
          const Row(
            children: [
              Icon(Icons.delete_outline, size: 20),
              SizedBox(width: 10),
              Icon(Icons.edit_outlined, size: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryCard(String title, String amount, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFAFD5FF).withOpacity(0.4),
              const Color(0xFF2E5FC9).withOpacity(0.4),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF3F6CC9)),
            const SizedBox(height: 6),
            Text(title, style: const TextStyle(fontSize: 11)),
            const SizedBox(height: 4),
            Text(
              amount,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mainButton({
    required String title,
    IconData? icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: const Color(0xFFB7C1E8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) Icon(icon, size: 18, color: Colors.black87),
              if (icon != null) const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _historyButton(
      String title, {
        required bool isFilled,
        required VoidCallback onTap,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        height: 46,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor:
            isFilled ? const Color(0xFF4C3BCF) : Colors.transparent,
            side: isFilled
                ? null
                : const BorderSide(color: Color(0xFFD4D8E2)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onTap, // 🔥 use passed function
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isFilled ? Colors.white : Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: isFilled ? Colors.white : Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
