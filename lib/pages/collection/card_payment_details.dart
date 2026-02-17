import 'package:flutter/material.dart';
import 'package:laundry_pos_system_app/pages/collection/select_payment_method_upper_part_util.dart';

import 'amount_received_section.dart';
class CardPaymentDetailsForm extends StatelessWidget {
  const CardPaymentDetailsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SelectPaymentMethodUpperPartUtil(),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9E6F2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Amount Received",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 16),

                      _customTextField("Card Holder Name"),
                      const SizedBox(height: 12),
                      _customTextField("Card Number"),
                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(child: _customTextField("MM/YY")),
                          const SizedBox(width: 12),
                          Expanded(child: _customTextField("CVV Number")),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 95),

              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2FA65A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AmountReceivedSection()));
                    },
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Reusable TextField
  Widget _customTextField(String hint) {
    return SizedBox(
      height: 48,
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}