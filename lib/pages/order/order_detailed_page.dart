import 'package:flutter/material.dart';
import 'package:laundry_pos_system_app/pages/order/order_received_screen.dart';
import '../../model/order_model.dart';
import 'invoice_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsScreen({super.key, required this.order});

  bool get isPending => order.orderStatus.toLowerCase() == "pending";

  // ================= CONFIRM DIALOG =================

  void _showConfirmDialog(BuildContext context) {
    final bool isCancel = isPending;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(

                  child: Image.asset('assets/images/confirm_delete.gif.gif'),
                ),
                const Text(
                  "Are you sure ?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                Text(
                  isCancel
                      ? "Are you sure you want to Cancel this order?"
                      : "Are you sure you want to Delete this order?",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "No",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF04E45),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Yes",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ================= STATUS BOTTOM SHEET =================

  void _showStatusBottomSheet(BuildContext context) {
    String selectedStatus = order.orderStatus;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SafeArea(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Update Status",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 20),
              
                    _statusOption(
                      "Pending",
                      selectedStatus,
                      setState,
                      (val) => selectedStatus = val,
                    ),
                    _statusOption(
                      "Picked Up",
                      selectedStatus,
                      setState,
                      (val) => selectedStatus = val,
                    ),
                    _statusOption(
                      "In Progress",
                      selectedStatus,
                      setState,
                      (val) => selectedStatus = val,
                    ),
                    _statusOption(
                      "Delivered",
                      selectedStatus,
                      setState,
                      (val) => selectedStatus = val,
                    ),
                    _statusOption(
                      "Cancelled",
                      selectedStatus,
                      setState,
                      (val) => selectedStatus = val,
                    ),
              
                    const SizedBox(height: 20),
              
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff5E60CE),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const OrderReceivedScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Update",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 15),
            Transform.translate(
              offset: const Offset(0, -30),
              child: _buildProfileCard(),
            ),
            const SizedBox(height: 18),
            _buildOrderInfo(),
            const SizedBox(height: 22),
        
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Service Item",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ),
            ),
        
            const SizedBox(height: 10),
        
            _serviceItem("Shirt", "Pressing", "1", "AED 3.50"),
            _serviceItem("T-Shirt", "Washing", "1", "AED 3.50"),
        
            const Spacer(),
        
            _buildSummary(),
        
            const SizedBox(height: 16),
        
            _buildBottomButtons(context),
        
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================

  Widget _buildHeader() {
    return Container(
      height: 120,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Color(0xff3F6EDC),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: const SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Order Details",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(Icons.notifications_none, color: Colors.white),
          ],
        ),
      ),
    );
  }

  // ================= PROFILE CARD =================

  Widget _buildProfileCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffE9ECF5),
              ),
              child: Center(
                child: Text(
                  order.customerName.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.customerName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 3),
                  // Text(order.phone, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 3),
                  // Text(
                  //   order.address,
                  //   style: const TextStyle(color: Colors.grey),
                  // ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      order.orderStatus,
                      style: TextStyle(
                        color: isPending ? Colors.orange : Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.edit_outlined, size: 18),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "Order Id: ",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                // TextSpan(
                //   text: order.id,
                //   style: const TextStyle(color: Color(0xff3F6EDC)),
                // ),
              ],
            ),
          ),
          Text(order.orderDate, style: const TextStyle(color: Colors.grey)),
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
      // child: Column(
      //   children: [
      //     _SummaryRow("SubTotal", "AED ${order.subtotal.toStringAsFixed(2)}"),
      //     _SummaryRow(
      //       "Discount(1%)",
      //       "AED ${order.discount.toStringAsFixed(2)}",
      //     ),
      //     _SummaryRow("Total", "AED ${order.total.toStringAsFixed(2)}"),
      //   ],
      // ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => _showConfirmDialog(context),
              child: Text(isPending ? "Cancel Order" : "Delete Order"),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (isPending) {
                  _showStatusBottomSheet(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => InvoiceScreen(order: order),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4845D2),
              ),
              child: Text(
                isPending ? "Update Status" : "View Invoice",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
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

Widget _statusOption(
  String title,
  String selectedValue,
  StateSetter setState,
  Function(String) onChanged,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: InkWell(
      onTap: () {
        setState(() {
          onChanged(title);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xffEDE7F6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: title,
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  onChanged(value!);
                });
              },
            ),
            Text(title),
          ],
        ),
      ),
    ),
  );
}

Widget _serviceItem(String title, String type, String qty, String price) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffE6E1F7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(width: 6),
              Text("($type)", style: const TextStyle(color: Colors.blue)),
              const SizedBox(width: 6),
              Text("× $qty"),
            ],
          ),
          Text(price, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    ),
  );
}
