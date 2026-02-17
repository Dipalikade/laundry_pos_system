import 'package:flutter/material.dart';
import 'package:laundry_pos_system_app/pages/home/Scan%20QR/qr_scan_failed.dart';
import '../../../util/header.dart';

class StatusUpdatedScreen extends StatefulWidget {
  final String status;
  final Color color;
  const StatusUpdatedScreen({super.key,required this.status,required this.color});

  @override
  State<StatusUpdatedScreen> createState() => _StatusUpdatedScreenState();
}

class _StatusUpdatedScreenState extends State<StatusUpdatedScreen> {
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
                headerUi(title: "Update Order Status"),
        
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
        
                        /// 🔹 GIF IMAGE
                        Image.asset(
                          "assets/images/status_updated_gif.gif",
                          height: 120,
                        ),
        
                        const SizedBox(height: 15),
        
                        /// 🔹 Title
                        const Text(
                          "Status Updated",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E3A87),
                          ),
                        ),
        
                        const SizedBox(height: 8),
        
                        /// 🔹 Subtitle
                         Text(
                          "Order has been marked as ${widget.status}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 13, color: Colors.black54),
                        ),
        
                        const SizedBox(height: 30),
        
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
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Order ID + Status
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Order ID",
                                        style: TextStyle(fontSize: 12),
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
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: widget.color,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      widget.status,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
        
                              const SizedBox(height: 12),
                              const Divider(),
                              const SizedBox(height: 12),
        
                              _infoRow(Icons.person, "John Doe"),
                              const SizedBox(height: 6),
                              _infoRow(Icons.phone, "9876543201"),
                              const SizedBox(height: 6),
                              _infoRow(
                                Icons.location_on,
                                "Emirates Towers Metro Station, Dubai",
                              ),
                            ],
                          ),
                        ),
        
                        const Spacer(),
        
                        /// 🔹 Done Button
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
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>QrScanFailedScreen()));
                            },
                            child: const Text(
                              "Done",
                              style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),
                            ),
                          ),
                        ),
        
                        const SizedBox(height: 10),
        
                        /// 🔹 View Full Order
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
                              "View Full Order",
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
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
      ],
    );
  }
}
