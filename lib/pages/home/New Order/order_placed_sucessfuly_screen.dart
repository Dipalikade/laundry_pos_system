import 'package:flutter/material.dart';
import 'package:laundry_pos_system_app/util/header.dart';

import '../../order/order_body.dart';


class OrderSuccessScreen extends StatefulWidget {
  final String customerName; // ✅ Store the value

  const OrderSuccessScreen({
    super.key,
    required this.customerName,
  });

  @override
  State<OrderSuccessScreen> createState() =>
      _OrderSuccessScreenState();
}

class _OrderSuccessScreenState
    extends State<OrderSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FF),
      body: SafeArea(
        child: Column(
          children: [
            // 🔵 Top Header
            headerUi(title: "Add New Customer"),

            // 🌥️ Background + Content
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/images/image 88.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [

                    /// ✅ Done GIF
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: Image.asset(
                        "assets/images/done_mark.gif",
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// ✅ Title
                    const Text(
                      "Order Received!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF4845D2),
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// ✅ Dynamic Subtitle
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(
                          horizontal: 40),
                      child: Text(
                        "The order for ${widget.customerName} has been\nsuccessfully created",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    /// 🧑 Illustration
                    Image.asset(
                      "assets/images/image 87.png",
                      height: 160,
                    ),

                    const SizedBox(height: 30),

                    /// 🔘 Button
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(
                          horizontal: 24),
                      child: ElevatedButton(
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color(
                              0xFF4845D2),
                          minimumSize:
                          const Size(
                              double.infinity,
                              48),
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius
                                .circular(8),
                          ),
                        ),
                        onPressed: () {

                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add,color: Colors.white,),
                            SizedBox(width: 10,),
                            const Text(
                              "Create Another Orders",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight:
                                FontWeight.w500,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(
                          horizontal: 24),
                      child: ElevatedButton(
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize:
                          const Size(
                              double.infinity,
                              48),
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius
                                .circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OrdersBody()));
                        },
                        child: const Text(
                          "View Order List",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight:
                            FontWeight.w500,
                            color: Colors.grey,
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