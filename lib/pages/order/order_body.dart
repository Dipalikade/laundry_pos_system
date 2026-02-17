import 'package:flutter/material.dart';
import 'package:laundry_pos_system_app/util/header.dart';
import '../../model/order_model.dart';
import 'order_detailed_page.dart';

class OrdersBody extends StatelessWidget {
  const OrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FF),
      body: SafeArea(
        child: Column(
          children: [
            /// 🔵 Header
            headerUi(title: 'Order List'),

            /// 🔍 Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: _searchBar(),
            ),

            /// 📋 Order List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  OrderCard(
                    order: OrderModel(
                      orderId: "TMS/ORD-01",
                      customerName: "John Doe",
                      phone: "9876543201",
                      address: "Marina Pinnacle, Dubai",
                      status: "Pending",
                      total: 6.93,
                      date: "Dec 17, 2025, 09:42 AM",
                      subtotal: 7.00,
                      discount: 0.07,
                    ),
                  ),
                  OrderCard(
                    order: OrderModel(
                      orderId: "TMS/ORD-02",
                      customerName: "Jane Smith",
                      phone: "9876543210",
                      address: "Emirates Towers, Dubai",
                      status: "Delivered",
                      total: 12.50,
                      date: "Dec 18, 2025, 11:30 AM",
                      subtotal: 7.00,
                      discount: 0.07,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔍 Search Bar Widget
  Widget _searchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search Orders',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: const Icon(Icons.tune),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xffE0E0E0)),
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OrderDetailsScreen(order: order),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFE8EDFF),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// LEFT SIDE
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow(Icons.person, order.customerName),
                  const SizedBox(height: 6),
                  _infoRow(Icons.phone, order.phone, small: true),
                  const SizedBox(height: 6),
                  _infoRow(Icons.location_on, order.address, small: true),
                ],
              ),
            ),

            /// RIGHT SIDE
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: order.status == "Pending"
                        ? const Color(0xFFFFE3C6)
                        : const Color(0xFFDFF1EC),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    order.status,
                    style: TextStyle(
                      fontSize: 11,
                      color: order.status == "Pending"
                          ? const Color(0xFFB26A00)
                          : const Color(0xFF2E7D6B),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'AED ${order.total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Icon(Icons.arrow_forward_ios, size: 14),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text, {bool small = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: small ? 14 : 16,
          color: Colors.black45,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: small ? 12 : 14,
              fontWeight:
              small ? FontWeight.normal : FontWeight.w600,
              color: small ? Colors.black54 : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
