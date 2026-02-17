import 'package:flutter/material.dart';
import 'package:laundry_pos_system_app/pages/home_dashboard.dart';
import '../../util/header.dart';

class PaymentCollectedScreen extends StatelessWidget {
  const PaymentCollectedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          /// 🌊 BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              "assets/images/image 88.png",
              fit: BoxFit.cover,
            ),
          ),

          Column(
            children: [

              /// 🔵 HEADER
              headerUi(title: "Payment Collected"),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      /// 🎉 SUCCESS GIF
                      Image.asset(
                        "assets/images/balanced_collected_sucessfully.gif", // your gif path
                        height: 120,
                      ),

                      const SizedBox(height: 24),

                      /// ✅ SUCCESS TEXT
                      const Text(
                        "Pending balance collected\nsuccessfully",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF27306B),
                        ),
                      ),

                      const SizedBox(height: 40),

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

                            /// LEFT DETAILS
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "#TMS/COL-01",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(height: 8),

                                  Row(
                                    children: [
                                      Icon(Icons.person,
                                          size: 14,
                                          color: Colors.grey),
                                      SizedBox(width: 6),
                                      Text("John Doe",
                                          style:
                                          TextStyle(fontSize: 12)),
                                    ],
                                  ),

                                  SizedBox(height: 6),

                                  Row(
                                    children: [
                                      Icon(Icons.phone,
                                          size: 14,
                                          color: Colors.grey),
                                      SizedBox(width: 6),
                                      Text("9876543201",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                              Colors.grey)),
                                    ],
                                  ),

                                  SizedBox(height: 6),

                                  Row(
                                    children: [
                                      Icon(Icons.payment,
                                          size: 14,
                                          color: Colors.grey),
                                      SizedBox(width: 6),
                                      Text("Payment",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                              Colors.grey)),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            /// RIGHT AMOUNT SECTION
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
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
                                    fontWeight:
                                    FontWeight.bold,
                                    color: Color(0xFFB0668D),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// 🟣 DONE BUTTON
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        const Color(0xFF5A4FCF),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeDashboardScreen()),
                              (route) => false,
                        );
                      },
                      child: const Text(
                        "Done",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}