import 'package:flutter/material.dart';
import 'package:laundry_pos_system_app/pages/profile/profile_screen.dart';
import '../util/app_bottom_nav.dart';
import 'PickUps/pickup_body.dart';
import 'collection/collection_body.dart';
import 'home/home_body.dart';
import 'order/order_body.dart';

class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeBody(),
    OrdersBody(),
    TodaysCollectionsScreen(),
    PickupBody(),
    ProfileBody(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
      ),

      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}