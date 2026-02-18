import 'package:flutter/material.dart';

import '../login/loginscreen.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          // 🔵 TOP BLUE CONTAINER (NOT APPBAR)
          Container(
            height: 160,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: const BoxDecoration(
              color: Color(0xFF2F66C8),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
            ),
            child: Row(
              children: const [
                Icon(Icons.arrow_back, color: Colors.white),
                SizedBox(width: 12),
                Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // 🧾 PROFILE CARD (OVERLAPPING)
          Transform.translate(
            offset: const Offset(0, -50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Avatar
                    const CircleAvatar(
                      radius: 26,
                      backgroundColor: Color(0xFFE8EDFF),
                      child: Text(
                        'YA',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F66C8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Row(
                            children: [
                              Icon(Icons.person,size: 14, color: Colors.grey),
                              SizedBox(width: 2,),
                              Text(
                                'Yusuf Ali',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          // SizedBox(height: 4),
                          _ProfileRow(
                            icon: Icons.badge,
                            text: 'TMS/DRV-1024',
                          ),
                          _ProfileRow(
                            icon: Icons.phone,
                            text: '9876543201',
                          ),
                          _ProfileRow(
                            icon: Icons.location_on,
                            text: 'Emirates Towers Metro Station, Dubai',
                          ),
                        ],
                      ),
                    ),

                    // Edit Icon
                    Icon(Icons.edit, size: 18),
                  ],
                ),
              ),
            ),
          ),

          // const SizedBox(height: 8),

          // 📅 TODAY'S TITLE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Today's",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Icon(Icons.calendar_today, size: 18),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // 📊 STATS CARDS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: const [
                _StatCard(
                  title: 'Pickups Completed',
                  value: '03',
                  imagepath: 'assets/images/twemoji_pickup-truck.png',
                ),
                SizedBox(width: 10),
                _StatCard(
                  title: 'Pending Pickups',
                  value: '01',
                  imagepath: 'assets/images/twemoji_pickup-truck.png',
                ),
                SizedBox(width: 10),
                _StatCard(
                  title: 'Total Item Collected',
                  value: '12',
                  imagepath: 'assets/images/noto_package.png',
                ),
              ],
            ),
          ),

          const SizedBox(height: 200),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFDB3B44),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false,
                  );
                },
                icon: const Icon(Icons.logout,color: Colors.white,),
                label: const Text('Logout',style: TextStyle(color: Colors.white),),
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}


class _ProfileRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ProfileRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.grey),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}


class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String imagepath;

  const _StatCard({
    required this.title,
    required this.value,
    required this.imagepath,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: const Color(0xFFE8EDFF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Image.asset(imagepath),
            const SizedBox(height: 6),


            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}