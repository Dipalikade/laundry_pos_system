import 'package:flutter/material.dart';
import '../../model/order_model.dart';
import 'order_delivered_screen.dart';

class InvoiceScreen extends StatelessWidget {
  final OrderModel order;

  const InvoiceScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    bool isDelivered = order.orderStatus.toLowerCase() == "delivered";

    return Scaffold(
      backgroundColor: const Color(0xffF2F3F7),
      body: Stack(children: [
        /// 🔵 BLUE HEADER (BACKGROUND)
        Container(
          height: 160,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            color: Color(0xff3F6EDC),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: const SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Invoice",
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
        ),

        /// 📄 MAIN CONTENT
        SingleChildScrollView(
          padding: const EdgeInsets.only(top: 110,left: 20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🧾 FLOATING WHITE CARD
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Id: ${order.id}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          order.orderDate,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      "assets/images/image 89.png",
                      height: 70,
                      width: 70,
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// BILLED TO
              const Text(
                "Billed To",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 12),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: const Color(0xffE6E9F8),
                    child: Text(
                      order.customerName.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff3F6EDC),
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
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Text(order.phone,
                        //     style: const TextStyle(color: Colors.grey)),
                        const SizedBox(height: 4),
                        // Text(order.address,
                        //     style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  Text(
                    order.orderStatus,
                    style: TextStyle(
                      color: isDelivered ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Icon(Icons.edit,color: Colors.black,size: 18,)
                ],
              ),

              const SizedBox(height: 25),

              /// SERVICE ITEM
              const Text(
                "Service Item",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 12),

              _serviceItem("Shirt", "Pressing", "1", "AED 3.50"),
              _serviceItem("T-Shirt", "Washing", "1", "AED 3.50"),

              const SizedBox(height: 30),

              /// SUMMARY
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xffEDE9F7),
                  borderRadius: BorderRadius.circular(12),
                ),
                // child: Column(
                //   children: [
                //     _row("Subtotal",
                //         "AED ${order.subtotal.toStringAsFixed(2)}"),
                //     _row("Discount (1%)",
                //         "- AED ${order.discount.toStringAsFixed(2)}"),
                //     _row(
                //       "Total",
                //       "AED ${order.total.toStringAsFixed(2)}",
                //       bold: true,
                //     ),
                //   ],
                // ),
              ),

              const SizedBox(height: 60),

              /// BUTTONS
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text("Share"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDeliveredScreen(
                              customerName: order.customerName,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff5E60CE),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Print",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _row(String title, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          )
        ],
      ),
    );
  }

  Widget _serviceItem(String title, String type, String qty, String price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
    );
  }
}
