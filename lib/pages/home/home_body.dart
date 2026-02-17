import 'package:flutter/material.dart';

import '../../util/header.dart';
import 'Scan QR/Scan_qr_code.dart';
import 'New Order/new_order.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: Column(
        children: [
          headerUi(title: "Demo laundary",),
          // SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    _statCard(
                      color: const Color(0xFFE8EDFF),
                      value: '3',
                      title: "Today's \nPickups",
                      imagepath: 'assets/images/image 79.png',
                    ),
                    const SizedBox(width: 10),
                    _statCard(
                      color: const Color(0xFFE6F4F1),
                      value: '5',
                      title: "Today's \nDeliveries",
                      imagepath: 'assets/images/image 81.png',
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _paymentCard(),
                const SizedBox(height: 24),
                const Text(
                  'Quick Actions',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerListBody()));
                      },
                        child: _ActionCard(imagepath: 'assets/images/image 80.png', title: 'New Order')),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ScanInvoiceQRScreen()));
                      },
                        child: _ActionCard(imagepath: 'assets/images/image 82.png', title: 'Scan QR')),
                    GestureDetector(
                      onTap: (){
                      },
                        child: _ActionCard(imagepath: 'assets/images/image 84.png', title: 'Add Customer')),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Text(
                      'Assigned Today’s',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    Text("View All",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
                  ],
                ),
                const SizedBox(height: 12),
                _taskTile(
                  name: 'John Doe',
                  id: '#TMS/PK-01',
                  time: 'Pickup at 09:00 AM',
                  location: 'Downtown, Dubai',
                ),
                _taskTile(
                  name: 'Alice Smith',
                  id: '#TMS/PK-04',
                  time: 'Pickup at 10:00 AM',
                  location: 'Dubai',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard({
    required Color color,
    required String value,
    required String title,
    required String imagepath,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imagepath),
            const SizedBox(height: 8),
            Spacer(),
            Column(
              children: [
                Text(
                  value,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _paymentCard() {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFE1E8), Color(0xFFFFF1F4)],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/image 83.png'),
          Spacer(),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AED 3,250',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text('Pending \nPayment', style: TextStyle(color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _taskTile({
    required String name,
    required String id,
    required String time,
    required String location,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EDFF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFFFFE1A1),
            child: Icon(Icons.person, color: Colors.orange),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person,size: 15,color: Colors.grey,),
                        SizedBox(width: 2,),
                        Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(width: 8),
                        Text(
                          id,
                          style: const TextStyle(fontSize: 11, color: Color(0xFF2F66C8)),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.timelapse,size: 15,color: Colors.grey,),
                    SizedBox(width: 2,),
                    Text(time, style: const TextStyle(fontSize: 12)),
                  ],
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    Icon(Icons.location_on,size: 15,color: Colors.grey,),
                    SizedBox(width: 2,),
                    Text(
                      location,
                      style: const TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String imagepath;
  final String title;

  const _ActionCard({required this.imagepath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
          color:  const Color(0xFFE8EDFF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Image.asset(imagepath),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}