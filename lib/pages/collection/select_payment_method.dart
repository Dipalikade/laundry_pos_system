import 'package:flutter/material.dart';
import 'package:laundry_pos_system_app/pages/collection/select_payment_method_upper_part_util.dart';


import 'card_payment_details.dart';

class SelectPaymentMethod extends StatefulWidget {
  const SelectPaymentMethod({super.key});

  @override
  State<SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {

  String selectedPayment = "Cash";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F5),
      body: SafeArea(
        child: Column(
          children: [
            SelectPaymentMethodUpperPartUtil(),
            
            // 💳 Payment Method Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8E6F2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select Payment Method",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 15),
        
                    paymentOption("Cash", Icons.money),
                    paymentOption("UPI", Icons.qr_code),
                    paymentOption("Card", Icons.credit_card),
                  ],
                ),
              ),
            ),
        
            const Spacer(),
        
            // ✅ Continue Button
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CardPaymentDetailsForm()));
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
    );
  }

  // 🔘 Payment Option Widget
  Widget paymentOption(String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Radio<String>(
            value: value,
            groupValue: selectedPayment,
            activeColor: const Color(0xFF3F6CC9),
            onChanged: (val) {
              setState(() {
                selectedPayment = val!;
              });
            },
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Icon(icon, color: Colors.grey),
        ],
      ),
    );
  }
}