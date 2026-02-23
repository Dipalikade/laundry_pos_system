import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:laundry_pos_system_app/services/apibaseurl.dart';
import '../../../model/card_item_model.dart';
import '../../../model/customer_model.dart';
import 'order_placed_sucessfuly_screen.dart';


class AddonModel {
  final int id;
  final String name;
  final double price;
  final String? addonMessage;
  final int status;

  AddonModel({
    required this.id,
    required this.name,
    required this.price,
    this.addonMessage,
    required this.status,
  });

  factory AddonModel.fromJson(Map<String, dynamic> json) {
    return AddonModel(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      addonMessage: json['addonMessage'],
      status: json['status'],
    );
  }
}

class OrderPlacedSummeryScreen extends StatefulWidget {
  final Customer customer;
  final List<CartItem> cartItems;
  final double discountPercentage;

  const OrderPlacedSummeryScreen({
    super.key,
    required this.customer,
    required this.cartItems,
    required this.discountPercentage,
  });

  @override
  State<OrderPlacedSummeryScreen> createState() =>
      _OrderPlacedSummeryScreenState();
}

class _OrderPlacedSummeryScreenState extends State<OrderPlacedSummeryScreen> {
  late List<CartItem> localCart;
  late double discountPercentage;
  
  // Addon related variables
  List<AddonModel> availableAddons = [];
  AddonModel? selectedAddon;
  bool isLoadingAddons = true;

  @override
  void initState() {
    super.initState();
    localCart = List.from(widget.cartItems);
    discountPercentage = widget.discountPercentage;
    fetchAddons();
  }

  Future<void> fetchAddons() async {
    setState(() {
      isLoadingAddons = true;
    });

    try {
      final dio = Dio();
      final response = await dio.get(
        '${ApiConfig.baseUrl}service/service_addon/list',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final jsonData = response.data;
        if (jsonData['success'] == true) {
          final List<dynamic> addonsJson = jsonData['data'];
          setState(() {
            availableAddons = addonsJson
                .map((json) => AddonModel.fromJson(json))
                .where((addon) => addon.status == 1) // Only active addons
                .toList();
            isLoadingAddons = false;
          });
        }
      } else {
        setState(() {
          isLoadingAddons = false;
        });
        throw Exception('Failed to load addons');
      }
    } catch (e) {
      setState(() {
        isLoadingAddons = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading addons: $e')),
      );
    }
  }

  void increaseQty(int index) {
    setState(() {
      localCart[index].quantity++;
    });
  }

  void decreaseQty(int index) {
    if (localCart[index].quantity > 1) {
      setState(() {
        localCart[index].quantity--;
      });
    }
  }

  void deleteItem(int index) {
    setState(() {
      localCart.removeAt(index);
    });
  }

  double getSubTotal() {
    double total = 0;
    for (var item in localCart) {
      total += item.price * item.quantity;
    }
    return total;
  }

  double getAddonPrice() {
    return selectedAddon?.price ?? 0;
  }

  double getDiscountAmount() {
    return (getSubTotal() + getAddonPrice()) * (discountPercentage / 100);
  }

  double getTotalAmount() {
    return (getSubTotal() + getAddonPrice()) - getDiscountAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: Column(
          children: [
            /// 🔵 TOP BLUE HEADER
            Container(
              height: 140,
              padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
              decoration: const BoxDecoration(
                color: Color(0xFF3F6CC9),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Create Order",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        
            /// 🧾 CUSTOMER CARD
            Transform.translate(
              offset: const Offset(0, -40),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.grey.shade200,
                        child: Text(
                          widget.customer.name[0],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.customer.name,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(widget.customer.type,style: const TextStyle(fontSize: 12),),
                            const SizedBox(height: 4),
                            Text(widget.customer.mobileNo,style: const TextStyle(fontSize: 12)),
                            const SizedBox(height: 4),
                            Text(
                              widget.customer.address,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        
            /// 🛒 CART LIST
            Expanded(
              child: localCart.isEmpty
                  ? const Center(child: Text("No items in cart"))
                  : ListView.builder(
                      padding: const EdgeInsets.only(left: 16,right: 16),
                      itemCount: localCart.length,
                      itemBuilder: (context, index) {
                        final item = localCart[index];
        
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDDE2F4),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.serviceType,
                                      style: const TextStyle(color: Colors.blue),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "₹ ${item.price}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  _qtyButton(
                                    icon: Icons.remove,
                                    onTap: () => decreaseQty(index),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Text(
                                      item.quantity.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  _qtyButton(
                                    icon: Icons.add,
                                    onTap: () => increaseQty(index),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () => deleteItem(index),
                                    child: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),

            /// 📦 ADDON DROPDOWN MENU
            if (!isLoadingAddons && availableAddons.isNotEmpty)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.black.withOpacity(0.05),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Additional Service",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<AddonModel>(
                          value: selectedAddon,
                          hint: const Text("Select an addon"),
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down),
                          items: availableAddons.map((addon) {
                            return DropdownMenuItem<AddonModel>(
                              value: addon,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(addon.name),
                                  const SizedBox(width: 10),
                                  Text(
                                    "₹ ${addon.price.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF4845D2),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (AddonModel? newValue) {
                            setState(() {
                              selectedAddon = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                    if (selectedAddon != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Selected:",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "${selectedAddon!.name} (₹ ${selectedAddon!.price.toStringAsFixed(2)})",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF4845D2),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

            const SizedBox(height: 8),
            _buildSummary(),
            const SizedBox(height: 16),
        
            /// BOTTOM BUTTONS
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Color(0xFFCDD2E1)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Place order logic with selected addon
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderSuccessScreen(
                              customerName: widget.customer.name,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4845D2),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Place Order",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummary() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xffEDE7F6),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          _SummaryRow("SubTotal", "₹ ${getSubTotal().toStringAsFixed(2)}"),
          
          /// Addon summary section
          if (selectedAddon != null) ...[
            const Divider(height: 20),
            _SummaryRow(
              "  • ${selectedAddon!.name}", 
              "₹ ${selectedAddon!.price.toStringAsFixed(2)}",
              isAddon: true,
            ),
            _SummaryRow(
              "Addon Total", 
              "₹ ${getAddonPrice().toStringAsFixed(2)}",
              isBold: true,
            ),
          ],
          
          const Divider(height: 20),
          _SummaryRow(
            "Discount (${discountPercentage.toStringAsFixed(0)}%)",
            "- ₹ ${getDiscountAmount().toStringAsFixed(2)}",
          ),
          const Divider(height: 20),
          _SummaryRow(
            "Total", 
            "₹ ${getTotalAmount().toStringAsFixed(2)}",
            isBold: true,
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28,
        width: 28,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isBold;
  final bool isTotal;
  final bool isAddon;

  const _SummaryRow(
    this.title, 
    this.value, {
    this.isBold = false,
    this.isTotal = false,
    this.isAddon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isAddon ? 12 : 14,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
              color: isAddon ? Colors.grey.shade600 : Colors.black,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              fontSize: isTotal ? 16 : 14,
              color: isTotal ? const Color(0xFF4845D2) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}