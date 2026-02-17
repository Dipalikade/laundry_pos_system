import 'package:flutter/material.dart';
import 'package:laundry_pos_system_app/util/header.dart';


import '../../../model/card_item_model.dart';
import '../../../model/customer_model.dart';
import 'add_to_my_cart_screen.dart';

class AddServiceItemScreen extends StatefulWidget {
  final Customer customer;
  const AddServiceItemScreen({super.key,required this.customer});

  @override
  State<AddServiceItemScreen> createState() => _AddServiceItemScreenState();
}

class _AddServiceItemScreenState extends State<AddServiceItemScreen> {
  List<CartItem> cartItems = [];

  void addToCart(String title, String serviceType, double price) {
    final existingIndex =
    cartItems.indexWhere(
          (item) =>
      item.title == title &&
          item.serviceType == serviceType,
    );

    if (existingIndex >= 0) {
      cartItems[existingIndex].quantity++;
    } else {
      cartItems.add(
        CartItem(
          title: title,
          serviceType: serviceType,
          price: price,
          quantity: 1,
        ),
      );
    }

    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: Column(
          children: [
            headerUi(title: "Add Service Item"),
            const SizedBox(height: 16),

            /// SEARCH + CART
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: "Search Item Here",
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddToMyCartScreen(
                            customer: widget.customer,
                            cartItems: cartItems,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3F6CC9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// GRID
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  itemCount: serviceItems.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final item = serviceItems[index];
                    return ServiceItemCard(
                      title: item['title'],
                      imagePath: item['imagePath'],
                      hasOptions: item['hasOptions'],
                      onAdd: addToCart,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// DUMMY DATA
final List<Map<String, dynamic>> serviceItems = [
  {"title": "Ghutra", "imagePath": "assets/images/service_item_images/ghutra.png", "hasOptions": false},
  {"title": "Under T-Shirt", "imagePath": "assets/images/service_item_images/under-t-shirt.png", "hasOptions": false},
  {"title": "Designer Saree", "imagePath": "assets/images/service_item_images/designer_saree.png", "hasOptions": false},
  {"title": "Long Dress", "imagePath": "assets/images/service_item_images/long_dress.png", "hasOptions": false},
  {"title": "Underwear & Socks", "imagePath": "assets/images/service_item_images/socks.png", "hasOptions": false},
  {"title": "Sweater", "imagePath": "assets/images/service_item_images/sweater.png", "hasOptions": false},
  {"title": "3PC Suit", "imagePath": "assets/images/service_item_images/3pc-suit.png", "hasOptions": false},
  {"title": "2PC Suit", "imagePath": "assets/images/service_item_images/2pc-suit.png", "hasOptions": false},
  {"title": "Pajama", "imagePath": "assets/images/service_item_images/pajama.png", "hasOptions": false},
  {"title": "Shoe", "imagePath": "assets/images/service_item_images/shoe.png", "hasOptions": false},
  {"title": "Trouser", "imagePath": "assets/images/service_item_images/trouser.png", "hasOptions": false},
  {"title": "T-Shirt", "imagePath": "assets/images/service_item_images/t-shirt.png", "hasOptions": true},
  {"title": "Shirt", "imagePath": "assets/images/service_item_images/shirt.png", "hasOptions": true},
  {"title": "Pillow Case", "imagePath": "assets/images/service_item_images/pillow_case.png", "hasOptions": false},
  {"title": "Hand Towel", "imagePath": "assets/images/service_item_images/hand_towel.png", "hasOptions": false},
];

/// SERVICE CARD
class ServiceItemCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final bool hasOptions;
  final Function(String title, String serviceType, double price) onAdd;

  const ServiceItemCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.hasOptions, required this.onAdd
  });

  void _showSimpleAddPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(title),
          content: const Text("Do you want to add this item to cart?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4B4BD6),
              ),
              onPressed: () {
                Navigator.pop(context);
                onAdd(title, "Normal", 3.50);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("$title added to cart"),
                  ),
                );
              },
              child: const Text(
                "Add",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (hasOptions) {
            _showServiceBottomSheet(context);
          } else {
            _showSimpleAddPopup(context);
          }
        },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 70, child: Image.asset(imagePath)),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style:
              const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= BOTTOM SHEET =================
  void _showServiceBottomSheet(BuildContext context) {
    String selectedService = "Pressing";

    bool usePreviousPrice = false;
    bool urgent = false;
    bool express = false;
    bool normal = false;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(22)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  /// RADIO SERVICES
                  Row(
                    children: [
                      Expanded(
                        child: _serviceCard(
                          title: "Pressing",
                          price: "AED 3.50",
                          imagePath: "assets/images/pressing.png",
                          selectedService: selectedService,
                          onTap: () {
                            setState(() {
                              selectedService = "Pressing";
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _serviceCard(
                          title: "Washing & Pressing",
                          price: "AED 6.00",
                          imagePath:
                          "assets/images/washing_and_pressing.png",
                          selectedService: selectedService,
                          onTap: () {
                            setState(() {
                              selectedService =
                              "Washing & Pressing";
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// CHECKBOXES
                  _checkTile(
                    title: "Use Previous Price",
                    subtitle: "Last Price: AED 3.50",
                    value: usePreviousPrice,
                    onChanged: (val) =>
                        setState(() => usePreviousPrice = val),
                  ),

                  _checkTile(
                    title: "Urgent Delivery",
                    subtitle: "Delivery In 2-4 Hrs",
                    price: "AED 20.00",
                    value: urgent,
                    onChanged: (val) =>
                        setState(() => urgent = val),
                  ),

                  _checkTile(
                    title: "Express Delivery",
                    subtitle: "Delivery In 12 Hrs",
                    price: "AED 3.50",
                    value: express,
                    onChanged: (val) =>
                        setState(() => express = val),
                  ),

                  _checkTile(
                    title: "Normal Delivery",
                    subtitle: "Delivery In 24-48 Hrs",
                    price: "AED 3.50",
                    value: normal,
                    onChanged: (val) =>
                        setState(() => normal = val),
                  ),

                  const SizedBox(height: 20),

                  /// BUTTONS
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color(0xFF4B4BD6),
                          ),
                          onPressed: () {
                            if (!usePreviousPrice &&
                                !urgent &&
                                !express &&
                                !normal) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Select at least one option"),
                                ),
                              );
                              return;
                            }

                            // ✅ STEP 4 LOGIC STARTS HERE

                            double basePrice =
                            selectedService == "Pressing" ? 3.50 : 6.00;

                            double extraCharge = 0;

                            if (urgent) extraCharge += 20.00;
                            if (express) extraCharge += 3.50;
                            if (normal) extraCharge += 3.50;

                            double finalPrice = basePrice + extraCharge;

                            // ✅ ADD TO CART
                            onAdd(title, selectedService, finalPrice);

                            // ✅ CLOSE SHEET
                            Navigator.pop(context);
                          },
                          child: const Text("Add",
                              style: TextStyle(
                                  color: Colors.white)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// RADIO CARD
  Widget _serviceCard({
    required String title,
    required String price,
    required String imagePath,
    required String selectedService,
    required VoidCallback onTap,
  }) {
    bool isSelected = selectedService == title;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F1FF),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF4B4BD6)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 70, child: Image.asset(imagePath)),
            const SizedBox(height: 8),
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: const Color(0xFF4B4BD6),
            ),
            const SizedBox(height: 4),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            Text(price,
                style: const TextStyle(
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  /// CHECKBOX TILE
  Widget _checkTile({
    required String title,
    required bool value,
    required Function(bool) onChanged,
    String? subtitle,
    String? price,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Checkbox(
            value: value,
            activeColor: const Color(0xFF4B4BD6),
            onChanged: (val) => onChanged(val ?? false),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontWeight:
                            FontWeight.w500)),
                    if (price != null)
                      Row(
                        children: [
                          Text(price,
                              style: const TextStyle(
                                  fontWeight:
                                  FontWeight.w500)),
                          SizedBox(width: 10,),
                          const Icon(Icons.edit, size: 16)
                        ],
                      )
                  ],
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: const TextStyle(
                        fontSize: 11,
                        color: Colors.red),
                  ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}