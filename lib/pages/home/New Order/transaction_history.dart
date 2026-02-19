import 'package:flutter/material.dart';
import '../../../model/customer_model.dart';

class TransactionHistoryScreen extends StatefulWidget {
  final Customer customer;

  const TransactionHistoryScreen({super.key, required this.customer});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState
    extends State<TransactionHistoryScreen> {

  String selectedValue = "Last 30 Days";

  final List<String> dropdownItems = [
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

          /// 🔵 HEADER
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
                                  Text(widget.customer.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14)),
                                ],
                              ),

                              const SizedBox(height: 4),

                              Row(
                                children: [
                                  Icon(Icons.person_add_alt,size: 15,color: Colors.grey),
                                  SizedBox(width: 8,),
                                  Text(widget.customer.type ?? "Individual",
                                      style: const TextStyle(fontSize: 12)),
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

                /// HEADER ROW WITH DROPDOWN
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Transaction History",
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
                            value: selectedValue,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 18,
                            ),
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black),
                            items: dropdownItems.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedValue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// 🔵 TIMELINE (UNCHANGED)
                _timelineItem("12 Dec 2025   4:30 PM"),
                _timelineItem("9 Dec 2025    2:15 PM"),
                _timelineItem("5 Dec 2025   11:45 AM", isLast: true),


                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 TIMELINE ITEM (UNCHANGED)
  Widget _timelineItem(String dateTime, {bool isLast = false}) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 16, bottom: 12), // 🔥 reduced gap
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔵 TIMELINE LINE + DOT
            Column(
              children: [
                Container(
                  width: 2,
                  height: 6,
                  color: Colors.transparent,
                ),
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Color(0xFF3F6CC9),
                    shape: BoxShape.circle,
                  ),
                ),

                /// Line stops for last item
                Expanded(
                  child: Container(
                    width: 2,
                    color: isLast
                        ? Colors.transparent
                        : const Color(0xFF3F6CC9),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 14),

            /// 🔳 TRANSACTION CARD
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE6E6E6)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(dateTime,
                            style: const TextStyle(
                                fontSize: 11, color: Colors.grey)),
                        const SizedBox(height: 6),
                        const Text("AED 9,218.14",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("TMS/ORD-01",
                            style: TextStyle(fontSize: 12)),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.receipt_long,
                                size: 14, color: Colors.grey),
                            SizedBox(width: 6),
                            Text("Paid",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
