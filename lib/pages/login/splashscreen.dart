import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_pos_system_app/pages/home_dashboard.dart';
import 'package:laundry_pos_system_app/pages/login/loginscreen.dart';
import 'package:laundry_pos_system_app/providers/auth_provider.dart';
import '../HomePage/homescreen_1.dart';


class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Wait for 2 seconds (splash screen display time)
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      // Check authentication state from Riverpod
      final authState = ref.read(authProvider);
      
      if (authState.isAuthenticated) {
        // User is logged in, navigate to Home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeDashboardScreen()),
        );
      } else {
        // Check if there are saved credentials
        await ref.read(authProvider.notifier).checkSavedCredentials();
        
        // Check again after checking saved credentials
        final updatedAuthState = ref.read(authProvider);
        
        if (updatedAuthState.isAuthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeDashboardScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.local_laundry_service,
              size: 90,
              color: Colors.white,
            ),
            SizedBox(height: 16),
            Text(
              'Laundry Pos system',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}