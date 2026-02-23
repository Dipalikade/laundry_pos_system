import 'package:flutter/material.dart';
import 'package:laundry_pos_system_app/pages/collection/payment_collected_sucessfully_screen.dart';
import '../../util/header.dart';

class CollectionPaymentScreen extends StatefulWidget {
  final int realId;
  final String displayId;
  final String type;
  final String date;
  final String time;
  final String address;
  final String PhoneNumber;

  const CollectionPaymentScreen({
    super.key,
    required this.PhoneNumber,
    required this.type,
    required this.realId,
    required this.address,
    required this.time,
    required this.date,
    required this.displayId,
  });

  @override
  State<CollectionPaymentScreen> createState() =>
      _CollectionPaymentScreenState();
}

class _CollectionPaymentScreenState extends State<CollectionPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5FA),
      body: Column(
        children: [
          /// 🔵 HEADER
          headerUi(title: "Today’s Collections"),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 18),

                    /// 📦 COLLECTION INFO CARD
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAE7F4),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// LEFT SIDE DETAILS
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                Text(
                                  widget.displayId,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(height: 8),

                                Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 14,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      "John Doe",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 6),

                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      size: 14,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 6),
                                    Text(widget.PhoneNumber,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 6),

                                Row(
                                  children: [
                                    Icon(
                                      Icons.payment,
                                      size: 14,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 6),
                                    Text(widget.type,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          /// RIGHT SIDE AMOUNT
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/payment_collection.png",
                                height: 42,
                                width: 42,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                "Outstanding\nAmount",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFFB0668D),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "AED 850.00",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFB0668D),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    /// 🧾 TITLE
                    const Text(
                      "Scan QR code to pay AED 850.00",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 18),

                    /// 🧾 QR CARD
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 18,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFBFD6F3)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/payment_QR.png",
                            height: 170,
                            width: 170,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "demolaundry@upi",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Collecting AED 850.00",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFFB0668D),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),

          /// 🟢 CONTINUE BUTTON
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2FAE5C),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentCollectedScreen(
                          realId: widget.realId,
                          displayId: widget.displayId,
                          type: widget.type,
                          date: widget.date,
                          time: widget.time,
                          address: widget.address,
                          PhoneNumber: widget.PhoneNumber
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
