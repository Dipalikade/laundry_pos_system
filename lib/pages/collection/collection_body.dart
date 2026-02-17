import 'package:flutter/material.dart';
import 'package:laundry_pos_system_app/pages/collection/select_payment_method.dart';
import 'package:laundry_pos_system_app/util/header.dart';
import 'add_collection.dart';

enum CollectionStatus {
  collected,
  cancelled,
}

class TodaysCollectionsScreen extends StatelessWidget {
  const TodaysCollectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FF),
      body: Column(
        children: [
          // 🔵 Header
          headerUi(
            title: "Today’s Collections",
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // 🔍 Search + Filter
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search Collection",
                          prefixIcon: const Icon(Icons.search, size: 20),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6F8EEA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCollectionScreen()));
                      }, icon: Icon(Icons.add_box_outlined))
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // 📦 Collection Cards
                const CollectionCard(
                  id: "#TMS/COL-01",
                  type: "Cloth",
                  date: "25/12/2025",
                  time: "9 AM to 10 AM",
                  address: "Dubai",
                ),

                const CollectionCard(
                  id: "#TMS/COL-02",
                  type: "Payment",
                  date: "25/12/2025",
                  time: "11 AM to 12 PM",
                  address: "Dubai",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CollectionCard extends StatefulWidget {
  final String id;
  final String type;
  final String date;
  final String time;
  final String address;

  const CollectionCard({
    super.key,
    required this.id,
    required this.type,
    required this.date,
    required this.time,
    required this.address,
  });

  @override
  State<CollectionCard> createState() => _CollectionCardState();
}

class _CollectionCardState extends State<CollectionCard> {
  /// Default dropdown value
  CollectionStatus _status = CollectionStatus.collected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>SelectPaymentMethod())),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F1FD),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ID + Dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.id,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),

                // 🔽 Status Dropdown
                Container(
                  height: 34,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<CollectionStatus>(
                      value: _status,
                      icon: const Icon(Icons.keyboard_arrow_down, size: 18),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _status = value!;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: CollectionStatus.collected,
                          child: Text("Collected",style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        DropdownMenuItem(
                          value: CollectionStatus.cancelled,
                          child: Text("Cancelled"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            _infoRow("Collection Type", widget.type),
            _infoRow("Pickup Date", widget.date),
            _infoRow("Pickup Time", widget.time),
            _infoRow("Address", widget.address),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}