import 'package:flutter/material.dart';
import 'package:laundry_pos_system_app/pages/PickUps/pick_up_detailed_screen.dart';
import 'package:laundry_pos_system_app/util/header.dart';

class PickupBody extends StatefulWidget {
  const PickupBody({super.key});

  @override
  State<PickupBody> createState() => _PickupBodyState();
}

class _PickupBodyState extends State<PickupBody> {
  int selectedTab = 0;

  final List<String> tabs = ["Pending", "In Progress", "Completed"];

  // ================= DATA PER TAB =================
  final List<Map<String, String>> pendingPickups = [
    {
      "name": "John Doe",
      "phone": "9876543201",
      "address": "Marina Pinnacle, Dubai",
      "time": "10:00 AM",
    },
    {
      "name": "Alex Smith",
      "phone": "9123456780",
      "address": "Business Bay, Dubai",
      "time": "12:00 PM",
    },
  ];

  final List<Map<String, String>> inProgressPickups = [
    {
      "name": "John Doe",
      "phone": "9876543201",
      "address": "Marina Pinnacle, Dubai",
      "time": "10:00 AM",
    },
    {
      "name": "Emma Watson",
      "phone": "9988776655",
      "address": "JLT, Dubai",
      "time": "01:30 PM",
    },
  ];

  final List<Map<String, String>> completedPickups = [
    {
      "name": "John Doe",
      "phone": "9876543201",
      "address": "Marina Pinnacle, Dubai",
      "items": "2 Items",
      "timeRange": "11:30 AM - 11:46 AM",
    },
    {
      "name": "John Doe",
      "phone": "9876543201",
      "address": "Marina Pinnacle, Dubai",
      "items": "12 Items",
      "timeRange": "01:30 PM - 01:31 PM",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        headerUi(title: "Pickups"),
        const SizedBox(height: 12),
        _statusTabs(),
        const SizedBox(height: 12),
        Expanded(child: _pickupList()),
      ],
    );
  }
  
  // ================= TABS =================
  Widget _statusTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: List.generate(tabs.length, (index) {
            final isSelected = selectedTab == index;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => selectedTab = index),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF2F66C8)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tabs[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : Colors.black54,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // ================= TAB BASED LIST =================
  Widget _pickupList() {
    if (selectedTab == 0) {
      return _normalList(pendingPickups);
    } else if (selectedTab == 1) {
      return _normalList(inProgressPickups);
    } else {
      return _completedList();
    }
  }

  // ================= NORMAL LIST (Pending / In Progress) =================
  Widget _normalList(List<Map<String, String>> list) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return _pickupCard(
          name: item["name"]!,
          phone: item["phone"]!,
          address: item["address"]!,
          time: item["time"]!,
        );
      },
    );
  }

  // ================= COMPLETED LIST =================
  Widget _completedList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: completedPickups.length,
      itemBuilder: (context, index) {
        final item = completedPickups[index];
        return _completedPickupCard(
          name: item["name"]!,
          phone: item["phone"]!,
          address: item["address"]!,
          items: item["items"]!,
          timeRange: item["timeRange"]!,
        );
      },
    );
  }

  // ================= PICKUP CARD =================
  Widget _pickupCard({
    required String name,
    required String phone,
    required String address,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F1FD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person, size: 13, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                _infoRow(Icons.phone, phone),
                _infoRow(Icons.location_on, address),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Pickup at $time",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.purple,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.navigation,
                  size: 16,
                  color: Colors.white,
                ),
                label: const Text(
                  "Navigate",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F66C8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  textStyle: const TextStyle(fontSize: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================= COMPLETED CARD =================
  Widget _completedPickupCard({
    required String name,
    required String phone,
    required String address,
    required String items,
    required String timeRange,
  }) {
    return GestureDetector(
      onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>PickupDetailsScreen()));},
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F1FD),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                "Completed",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(timeRange,style: TextStyle(color: Colors.purple,fontSize: 12,fontWeight: FontWeight.bold),)
      
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _infoRow(Icons.phone, phone),
                  _infoRow(Icons.location_on, address),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                color: Color(0xFFEDE6FF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2F66C8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.receipt_long, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        items,
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        timeRange,
                        style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 12,
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
    );
  }

  // ================= INFO ROW =================
  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.grey),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
