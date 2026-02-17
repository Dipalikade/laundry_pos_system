import 'package:flutter/material.dart';
import 'package:laundry_pos_system_app/pages/home/Scan%20QR/status_updated_screen.dart';
import '../../../util/header.dart';

class ConfirmDelayStatusScreen extends StatefulWidget {
  final String status;
  final Color color;
  const ConfirmDelayStatusScreen({super.key,required this.status,required this.color});

  @override
  State<ConfirmDelayStatusScreen> createState() => _ConfirmDelayStatusScreenState();
}

class _ConfirmDelayStatusScreenState extends State<ConfirmDelayStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
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
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
        
                        /// 🔹 Top GIF Container
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/images/delay_gif.gif",
                              height: 110,
                              width: 110,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
        
                        const SizedBox(height: 25),
        
                        /// 🔹 Title
                        const Text(
                          "Confirm Delay Status",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2E3A87),
                          ),
                        ),
        
                        const SizedBox(height: 12),
        
                        /// 🔹 Subtitle
                        const Text(
                          "Are you sure you want to mark\nOrder ID TMS/ORD-01 as delayed?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.5,
                            color: Colors.black87,
                          ),
                        ),
        
                        const SizedBox(height: 28),
        
                        /// 🔹 Order Info Card
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDEAF3),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Order ID + Delay Tag
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Order ID",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "#TMS/ORD-01",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFD64545),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      "Delay",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
        
                              const SizedBox(height: 14),
                              const Divider(),
                              const SizedBox(height: 14),
        
                              _infoRow(Icons.person, "John Doe"),
                              const SizedBox(height: 8),
                              _infoRow(Icons.phone, "9876543201"),
                              const SizedBox(height: 8),
                              _infoRow(
                                Icons.location_on,
                                "Emirates Towers Metro Station, Dubai",
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
                              backgroundColor: const Color(0xFFD64545),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>StatusUpdatedScreen(status: widget.status,color: Colors.red,)));
                            },
                            child: const Text(
                              "Confirm",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
        
                        const SizedBox(height: 12),
        
                        /// 🔹 Cancel Button (Grey)
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE6E8F0),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                color: Color(0xFF3E6CCB),
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
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.black54),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
      ],
    );
  }
}
