import 'package:flutter/material.dart';
import 'package:laundry_pos_system_app/util/header.dart';

import 'order_body.dart';


class OrderReceivedScreen extends StatelessWidget {
  const OrderReceivedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FF),
      body: SafeArea(
        child: Column(
          children: [
            // 🔵 Top Header
           headerUi(title: "Order Received"),

            // 🌥️ Background + Content
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/image 88.png"), // optional
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const SizedBox(height: 10),

                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Image.asset(
                        "assets/images/done_mark.gif",
                        fit: BoxFit.contain,
                      ),
                    ),

                    // ✅ Title
                    const Text(
                      "Order Received!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF4845D2)),
                      ),

                    const SizedBox(height: 12),

                    // 📄 Subtitle
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        "The order for John Doe has been\nsuccessfully Delivered",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // 🧑‍💼 Illustration
                    Image.asset(
                      "assets/images/image 87.png",
                      height: 160,
                    ),

                    const SizedBox(height: 30),

                    // 🔘 Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4845D2),
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OrdersBody()));
                        },
                        child: const Text(
                          "Back to Orders",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white
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
      ),
    );
  }
}