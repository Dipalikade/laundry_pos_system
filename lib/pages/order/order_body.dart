import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../util/header.dart';
import '../../model/order_model.dart';
import '../../providers/order_provider.dart';
import 'order_detailed_page.dart';
import 'package:intl/intl.dart';

class OrdersBody extends ConsumerWidget {
  const OrdersBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(ordersProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FF),
      body: SafeArea(
        child: Column(
          children: [
            headerUi(title: 'Order List'),

            Padding(
              padding: const EdgeInsets.all(16),
              child: _searchBar(),
            ),

            Expanded(
              child: ordersAsync.when(
                loading: () =>
                const Center(child: CircularProgressIndicator()),
                error: (e, _) =>
                    Center(child: Text("Error: ${e.toString()}")),
                data: (orders) {
                  if (orders.isEmpty) {
                    return const Center(
                      child: Text("No Orders Found"),
                    );
                  }

                  return ListView.builder(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return OrderCard(order: orders[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search Orders',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: const Icon(Icons.tune),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
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
            color: Color(0xFFF5F1FD),
          // color: order.orderStatus == "Order Received"
          //     ? const Color(0xFFFFE3C6)
          //     : const Color(0xFFDFF1EC),
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
                  _infoRow(Icons.local_shipping, order.driverName, small: true),
                  const SizedBox(height: 6),
                  _infoRow(
                    Icons.calendar_today,
                    DateFormat('dd-MM-yyyy')
                        .format(DateTime.parse(order.orderDate)),
                    small: true,
                  ),
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
                    color: order.orderStatus == "Deleted"
                        ? Colors.red.shade200
                        : const Color(0xFFDFF1EC),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    order.orderStatus,
                    style: TextStyle(
                      fontSize: 11,
                      color: order.orderStatus == "Deleted"
                          ? Colors.red
                          : const Color(0xFF2E7D6B),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'AED ${order.grossTotal.toStringAsFixed(2)}',
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
