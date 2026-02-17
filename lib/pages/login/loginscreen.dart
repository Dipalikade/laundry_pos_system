import 'package:flutter/material.dart';
import '../home_dashboard.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // Logo
              Center(
                child: SizedBox(
                  width: 140,
                  height: 140,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [

                      /// 🔵 Blue Background PNG
                      Image.asset(
                        'assets/images/logo/logo_background.png', // your blue background png
                        width: 140,
                        height: 140,
                        fit: BoxFit.contain,
                      ),

                      /// ✨ Logo Ipsum PNG
                      Image.asset(
                        'assets/images/logo/Logo.png', // your logo ipsum png
                        width: 80,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              )
              ,

              const SizedBox(height: 32),

              // Title
              const Text(
                'Login to',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Demo Laundry',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 8),
              const Text(
                'Log in to continue managing customers & orders.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400
                ),
              ),

              const SizedBox(height: 32),

              // Email
              const Text('Email'),
              const SizedBox(height: 6),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Password
              const Text('Password'),
              const SizedBox(height: 6),
              TextField(
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Remember me
              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    onChanged: (value) {
                      setState(() {
                        rememberMe = value!;
                      });
                    },
                  ),
                  const Text('Remember Me'),
                ],
              ),

              const SizedBox(height: 20),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeDashboardScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2F66C8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
