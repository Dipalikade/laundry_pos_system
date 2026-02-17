import 'package:flutter/material.dart';
import '../../../util/header.dart';

class QrScanFailedScreen extends StatelessWidget {
  const QrScanFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔹 Background Image
          Positioned.fill(
            child: Image.asset("assets/images/image 88.png", fit: BoxFit.cover),
          ),

          Column(
            children: [
              /// 🔹 Header
              headerUi(title: "Scan Invoice QR"),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),

                      /// 🔹 Container with GIF
                      Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Image.asset(
                            "assets/images/scan_failed.gif",
                            height: 100,
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// 🔹 Title
                      const Text(
                        "QR Scan Failed",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E3A87),
                        ),
                      ),

                      const SizedBox(height: 8),

                      /// 🔹 Subtitle
                      const Text(
                        "We couldn’t find a matching order.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),

                      const SizedBox(height: 30),

                      /// 🔹 Retry Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3E6CCB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Retry Scan",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// 🔹 Enter Order ID
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD9DDE5),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Enter Order ID",
                            style: TextStyle(
                              color: Color(0xFF3E6CCB),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40,),

                      /// 🔹 Bottom Info Text
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.info_rounded,
                            size: 18,
                            color: Colors.black87,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Ensure the QR is clear and correctly printed on the invoice",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                    ],
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
