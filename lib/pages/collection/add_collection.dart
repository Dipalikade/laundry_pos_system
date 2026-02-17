import 'package:flutter/material.dart';
import 'package:laundry_pos_system_app/pages/collection/payment_collection_form.dart';
import 'package:laundry_pos_system_app/util/header.dart';
import 'cloth_collection_form.dart';

enum CollectionTab { cloth, payment }

class AddCollectionScreen extends StatefulWidget {
  const AddCollectionScreen({super.key});

  @override
  State<AddCollectionScreen> createState() => _AddCollectionScreenState();
}

class _AddCollectionScreenState extends State<AddCollectionScreen> {
  CollectionTab selectedTab = CollectionTab.cloth;

  @override
  Widget build(BuildContext context) {
    final String headerTitle =
    selectedTab == CollectionTab.cloth
        ? "Add Cloth Collection"
        : "Add Payment Collection";

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: Column(
          children: [
        
            /// 🔵 Header
            headerUi(title: headerTitle),
        
            const SizedBox(height: 10),
        
            /// 🔹 Modern Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    _tab("Cloth Collection", CollectionTab.cloth),
                    _tab("Payment Collection", CollectionTab.payment),
                  ],
                ),
              ),
            ),
        
            const SizedBox(height: 15),
        
            /// 🔹 Animated Content
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: selectedTab == CollectionTab.cloth
                    ? const ClothCollectionForm(key: ValueKey("cloth"))
                    : const PaymentCollectionForm(key: ValueKey("payment")),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tab(String text, CollectionTab tab) {
    final bool isSelected = selectedTab == tab;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = tab),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF2F66C8) : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
