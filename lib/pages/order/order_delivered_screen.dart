import 'package:flutter/material.dart';
import 'package:laundry_pos_system_app/pages/order/order_body.dart';
import 'package:laundry_pos_system_app/util/header.dart';

class OrderDeliveredScreen extends StatelessWidget {
  final String customerName;

  const OrderDeliveredScreen({
    super.key,
    required this.customerName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FB),
      body: Stack(
        children: [

          /// 🔵 BLUE HEADER
          headerUi(title: "Order Delivered"),

          /// 🌊 BACKGROUND IMAGE
          Positioned.fill(
            top: 125,
            child: Image.asset(
              "assets/images/image 88.png",
              fit: BoxFit.cover,
            ),
          ),

          /// 🎉 CENTER CONTENT
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Image.asset(
                    "assets/images/image 103.png",
                    height: 180,
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Pickup Completed!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff1D2B53),
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// 🔥 DYNAMIC NAME HERE
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        height: 1.7
                      ),
                      children: [
                        const TextSpan(
                          text:
                          "You have successfully picked up the \npackages from ",
                        ),
                        TextSpan(
                          text: "$customerName.",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xff1D2B53),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OrdersBody()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4C45C6),
                        padding:
                        const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

