import 'package:flutter/material.dart';
import 'package:laundry_pos_system_app/pages/home/Scan%20QR/status_updated_screen.dart';

import '../../../util/header.dart';
import 'confirm_delay_screen.dart';

class UpdateOrderStatusScreen extends StatefulWidget {
  const UpdateOrderStatusScreen({super.key});

  @override
  State<UpdateOrderStatusScreen> createState() =>
      _UpdateOrderStatusScreenState();
}

class _UpdateOrderStatusScreenState
    extends State<UpdateOrderStatusScreen> {

  int selectedIndex = 1; // Default selected (Delivered)

  final List<IconData> statusIcons = [
    Icons.delivery_dining,   // Out for Delivery
    Icons.check_circle,      // Delivered
    Icons.access_time,       // Delay
  ];

  final List<String> statusList = [
    "Out for Delivery",
    "Delivered",
    "Delay",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F7),
      body: SafeArea(
        child: Column(
          children: [
        
            /// 🔹 Your Header
            headerUi(title: "Update Order Status"),
        
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
        
                    /// 🔹 Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDEAF3),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
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
                                        fontSize: 12,),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "#TMS/ORD-01",
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight.w600),
                                  ),
                                ],
                              ),
                              Container(
                                padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                  BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  "Pickup completed",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11),
                                ),
                              )
                            ],
                          ),
        
                          const SizedBox(height: 12),
                          const Divider(),
                          const SizedBox(height: 12),
        
                          /// Info
                          _infoRow(Icons.person, "John Doe"),
                          const SizedBox(height: 6),
                          _infoRow(Icons.phone, "9876543201"),
                          const SizedBox(height: 6),
                          _infoRow(Icons.location_on,
                              "Emirates Towers Metro Station, Dubai"),
        
                          const SizedBox(height: 12),
                          const Divider(),
                          const SizedBox(height: 12),
        
                          /// Update Title
                          const Text(
                            "Update Order Status",
                            style: TextStyle(
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Please choose the new status for this order",
                            style: TextStyle(
                                fontSize: 12,
                            ),
                          ),
        
                          const SizedBox(height: 16),
        
                          /// 🔥 Selectable Buttons
                          Column(
                            children: List.generate(
                              statusList.length,
                                  (index) => Padding(
                                padding:
                                const EdgeInsets.only(
                                    bottom: 10),
                                child: _statusButton(
                                    index),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
        
                    const Spacer(),
        
                    /// 🔹 Confirm Button
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
        
                            if (selectedIndex == 2) {
                              /// 🔴 If Delay Selected
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConfirmDelayStatusScreen(status:statusList[selectedIndex],color:Colors.red),
                                ),
                              );
                            } else {
                              /// 🟢 For Delivered & Out for Delivery
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StatusUpdatedScreen(
                                    status: statusList[selectedIndex],
                                    color: selectedIndex == 0
                                        ? Colors.orange
                                        : Colors.green,
                                  ),
                                ),
                              );
                            }
                          },
                        child: const Text(
                          "Confirm Status",
                          style: TextStyle(
                              fontWeight:
                              FontWeight.w600,
                          color: Colors.white),
                        ),
                      ),
                    ),
        
                    const SizedBox(height: 12),
        
                    /// 🔹 Cancel Button
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              color:
                              Color(0xFF3E6CCB),
                              fontWeight:
                              FontWeight.w600),
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

  /// 🔹 Status Button Widget
  Widget _statusButton(int index) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.orange,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            /// 🔹 Icon
            Icon(
              statusIcons[index],
              size: 18,
              color: isSelected ? Colors.white : Colors.orange,
            ),

            const SizedBox(width: 30),

            /// 🔹 Text
            Text(
              statusList[index],
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Info Row
  Widget _infoRow(
      IconData icon, String text) {
    return Row(
      children: [
        Icon(icon,
            size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style:
              const TextStyle(fontSize: 13)),
        ),
      ],
    );
  }
}