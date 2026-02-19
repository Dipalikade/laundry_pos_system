import 'package:flutter/material.dart';
import '../../../model/customer_model.dart';

class OrderHistoryScreen extends StatefulWidget {
  final Customer customer;

  const OrderHistoryScreen({super.key, required this.customer});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {

  String selectedFilter = "Last 30 Days";

  final List<String> filters = [
    "Last 30 Days",
    "Last 15 Days",
    "Last 7 Days",
  ];


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
      backgroundColor: const Color(0xFFF2F3F7),
      body: Stack(
        children: [

          /// 🔵 BLUE HEADER
          Container(
            height: 170,
            decoration: const BoxDecoration(
              color: Color(0xFF3F6CC9),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16,bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back,
                          color: Colors.white, size: 22),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Customer Details",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.notifications_none,
                    color: Colors.white, size: 22),
              ],
            ),
          ),

          /// 🔽 BODY
          SingleChildScrollView(
            child: Column(
              children: [

                const SizedBox(height: 115),

                /// 👤 CUSTOMER CARD
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  Icon(Icons.person,size: 15,color: Colors.grey,),
                                  SizedBox(width: 8,),
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
                                  Icon(Icons.person_add_alt,size: 15,color: Colors.grey),
                                  SizedBox(width: 8,),
                                  Text(
                                    widget.customer.type ?? "Individual",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 6),

                              Row(
                                children: [
                                  Icon(Icons.phone,size: 15,color: Colors.grey),
                                  SizedBox(width: 8,),
                                  Text(widget.customer.mobileNo,
                                      style: const TextStyle(fontSize: 12)),
                                ],
                              ),

                              const SizedBox(height: 4),

                              Row(
                                children: [
                                  Icon(Icons.email,size: 15,color: Colors.grey),
                                  SizedBox(width: 8,),
                                  Text(widget.customer.email ?? "",
                                      style: const TextStyle(fontSize: 12)),
                                ],
                              ),

                              const SizedBox(height: 4),

                              Row(
                                children: [
                                  Icon(Icons.location_on,size: 15,color: Colors.grey),
                                  SizedBox(width: 8,),
                                  Text(widget.customer.address ?? "",
                                      style: const TextStyle(fontSize: 12)),
                                ],
                              )

                            ],
                          ),
                        ),

                        const Icon(Icons.edit_outlined,
                            size: 20, color: Colors.grey),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                /// ORDER HISTORY HEADER
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Order History",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3EAF6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedFilter,
                            icon: const Icon(Icons.keyboard_arrow_down, size: 16),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                            onChanged: (value) {
                              setState(() {
                                selectedFilter = value!;
                              });
                            },
                            items: filters.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                          ),
                        ),
                      )

                    ],
                  ),
                ),

                const SizedBox(height: 12),

                /// ORDER LIST
                _orderCard("TMS/ORD-01", "03 Dec", "AED 125", "20 pts"),
                _orderCard("TMS/ORD-03", "03 Dec", "AED 209", "40 pts"),
                _orderCard("TMS/ORD-02", "03 Dec", "AED 365", "50 pts"),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 ORDER CARD
  Widget _orderCard(
      String orderId, String date, String amount, String loyalty) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE6E6E6)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// TOP ROW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(orderId,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500)),
                        const SizedBox(width: 6),
                        Text(date,
                            style: const TextStyle(
                                fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                    SizedBox(height: 6,),
                    Text("Wash & Ironing",
                        style: TextStyle(fontSize: 13)),
                    SizedBox(height: 6,),
                    Text("Loyalty Points: $loyalty",
                        style: const TextStyle(
                            fontSize: 12, color: Colors.orange)),

                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8EDF3),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        amount,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 6,),
                    const Text("Delivered",
                        style:
                        TextStyle(fontSize: 12, color: Colors.green)),
                    SizedBox(height: 6,),
                    const Text(
                      "View Details",
                      style:
                      TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ],
                )

              ],
            ),

          ],
        ),
      ),
    );
  }
}
