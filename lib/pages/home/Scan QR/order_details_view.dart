import 'package:flutter/material.dart';
import 'package:laundry_pos_system_app/pages/home/Scan%20QR/update_order_status_screen.dart';

import '../../../util/header.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F7),
      body: SafeArea(
        child: Column(
          children: [
        
            /// 🔹 Your Custom Header
            headerUi(title: "Order Details"),
        
            /// 🔹 Body
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
        
                    /// 🔹 Order Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDEAF3),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
        
                          /// Order ID + Status
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Order ID",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "#TMS/ORD-01",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
        
                              /// Green Status Pill
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                  BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  "Pickup completed",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                ),
                              )
                            ],
                          ),
        
                          const SizedBox(height: 12),
                          const Divider(),
        
                          const SizedBox(height: 12),
        
                          /// Customer Info
                          _infoRow(Icons.person, "John Doe"),
                          const SizedBox(height: 8),
                          _infoRow(Icons.phone, "9876543201"),
                          const SizedBox(height: 8),
                          _infoRow(Icons.location_on,
                              "Emirates Towers Metro Station, Dubai"),
        
                          const SizedBox(height: 12),
                          const Divider(),
                          const SizedBox(height: 12),
        
                          /// Current Status
                          const Text(
                            "Current Status",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "Pickup Completed",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
        
                          const SizedBox(height: 12),
                          const Divider(),
                          const SizedBox(height: 12),
        
                          /// Date
                          _infoRow(Icons.calendar_today,
                              "Dec 22, 2025, 10:30 AM"),
                          const SizedBox(height: 8),
                          _infoRow(Icons.assignment,
                              "Assigned To TMS/DRV-01"),
                        ],
                      ),
                    ),
        
                    const Spacer(),
        
                    /// 🔹 Update Order Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color(0xFF3E6CCB),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateOrderStatusScreen()));
                        },
                        child: const Text(
                          "Update Order Status",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
        
                    const SizedBox(height: 12),
        
                    /// 🔹 View Full Order Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color(0xFFD9DDE5),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "View Full Order",
                          style: TextStyle(
                            color: Color(0xFF3E6CCB),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
        
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Reusable Info Row
  static Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}