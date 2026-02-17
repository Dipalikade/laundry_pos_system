import 'package:flutter/material.dart';

class PickupDetailsScreen extends StatelessWidget {
  const PickupDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 🔵 Top Blue Header
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              color: Color(0xFF2F66C8),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Pickup Details",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(Icons.notifications_none, color: Colors.white),
                ],
              ),
            ),
          ),

          // 👤 Customer Card
          Transform.translate(
            offset: const Offset(0, -30),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Color(0xFFF5F1FD),
                      child: const Text(
                        "JD",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),

                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "John Doe",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Individual",
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(height: 6),
                          Text("9876543201",),
                          SizedBox(height: 6),
                          Text(
                            "Emirates Towers Metro Station, Dubai",
                            style: TextStyle(color: Colors.black,fontSize: 13),
                          ),
                        ],
                      ),
                    ),

                    // Icons
                    Column(
                      children: const [
                        Row(
                          children: [
                            Icon(Icons.delete_outline),
                            SizedBox(width: 12),
                            Icon(Icons.edit_outlined),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // 📦 Pickup Time Card
          _infoCard(
            icon: Icons.access_time,
            iconBg: const Color(0xFFC180BB),
            title: "Pickup at 12:00 PM",
            subtitle: "TMS/ORD-01 · 2 Packages\n• Shirt\n• T-Shirt",
            action: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF6F8EEA),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.near_me, size: 14, color: Colors.white),
                  SizedBox(width: 6),
                  Text(
                    "Navigate",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),

          // ⏰ Expected By Card
          _infoCard(
            icon: Icons.access_time_filled,
            iconBg: const Color(0xFFF1D3B3),
            title: "Expected By: 01:00 PM",
          ),

          const Spacer(),

          // 📞 Bottom Buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF27AE60),
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.call,color: Colors.white,),
                  label: const Text("Call Customer",style: TextStyle(color: Colors.white),),
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6F8EEA),
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Mark As Picked",style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Reusable Info Card
  static Widget _infoCard({
    required IconData icon,
    required Color iconBg,
    required String title,
    String? subtitle,
    Widget? action,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFF5F1FD),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600,color: Color(0xFFC180BB)),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ]
                ],
              ),
            ),
            ?action,
          ],
        ),
      ),
    );
  }
}