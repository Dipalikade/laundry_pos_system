
import 'package:flutter/material.dart';
import '../login/loginscreen.dart';

class Homescreen3 extends StatelessWidget {
  const Homescreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top blue section
            Expanded(
              flex: 6,
              child: Container(
                width: double.infinity,
                color: const Color(0xFF2F66C8), // close to image blue
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      'Boost Your Sales!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      height: 260,
                      child: Image.asset(
                        'assets/images/home_screen/homescreen_3.png',
                        fit: BoxFit.contain,
                        height: 260,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),

            // Bottom white section
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Manage collections, Apply discount, get paid \non the spot and boost your sales',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF5F6C7B),
                          height: 1.5,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 50),

                    // Dots indicator

                    // Bottom buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                          },
                          child: const Text(
                            'Skip',
                            style: TextStyle(color: Colors.black54,),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _dot(true),
                            _dot(false),
                            _dot(false),
                          ],
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                          },
                          child: const Text(
                            'Next',
                            style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _dot(bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 8 : 6,
      height: active ? 8 : 6,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF2F66C8) : Colors.grey.shade400,
        shape: BoxShape.circle,
      ),
    );
  }
}
