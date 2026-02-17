import 'package:flutter/material.dart';
import '../../util/header.dart';
import 'collection_qr_payment_screen.dart';

class AmountReceivedSection extends StatelessWidget {
  const AmountReceivedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F7),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [

            /// 🔵 HEADER
            headerUi(title: "Today's Collections"),

            const SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [

                    /// ===============================
                    /// 📄 COLLECTION INFO CARD
                    /// ===============================
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9E6F2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          /// LEFT DETAILS
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "#TMS/COL-01",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),

                              Row(
                                children: [
                                  Icon(Icons.person, size: 16, color: Colors.grey),
                                  SizedBox(width: 6),
                                  Text("John Doe"),
                                ],
                              ),

                              SizedBox(height: 6),

                              Row(
                                children: [
                                  Icon(Icons.phone, size: 16, color: Colors.grey),
                                  SizedBox(width: 6),
                                  Text("9876543201",
                                      style: TextStyle(color: Colors.grey)),
                                ],
                              ),

                              SizedBox(height: 6),

                              Row(
                                children: [
                                  Icon(Icons.payment,
                                      size: 16, color: Colors.grey),
                                  SizedBox(width: 6),
                                  Text("Payment",
                                      style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ],
                          ),

                          /// RIGHT SIDE
                          Column(
                            children: [
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: Image.asset(
                                  "assets/images/payment_collection.png",
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                "Outstanding\nAmount",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFFB0668D),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "AED 850.00",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFB0668D),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// ===============================
                    /// 💰 AMOUNT RECEIVED CARD
                    /// ===============================
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9E6F2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const Text(
                            "Amount Received",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 14),

                          /// AED FIELD
                          Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [

                                /// AED BOX
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF2F2F2),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "AED",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 8),

                                const Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: "Enter Amount Received",
                                      border: InputBorder.none,
                                      isCollapsed: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 14),

                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54),
                              children: [
                                TextSpan(text: "Total Payable :  "),
                                TextSpan(
                                  text: "AED 850.00",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// ===============================
            /// 🟢 CONTINUE BUTTON
            /// ===============================
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2FA84F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CollectionPaymentScreen()));
                  },
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}