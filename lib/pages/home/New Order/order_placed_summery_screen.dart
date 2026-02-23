import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:laundry_pos_system_app/pages/home/New%20Order/order_placed_sucessfuly_screen.dart';
import 'package:laundry_pos_system_app/services/apibaseurl.dart';
import '../../../model/card_item_model.dart';
import '../../../model/customer_model.dart';

// Addon model
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

class OrderSummaryScreen extends StatefulWidget {
  final Customer customer;
  final List<CartItem> cartItems;
  final double initialDiscount; // optional, default 0

  const OrderSummaryScreen({
    super.key,
    required this.customer,
    required this.cartItems,
    this.initialDiscount = 0,
  });

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  late List<CartItem> localCart;
  late double discountPercentage;

  // Addon
  List<AddonModel> availableAddons = [];
  AddonModel? selectedAddon;
  bool isLoadingAddons = true;

  // Date & time
  DateTime orderDate = DateTime.now();
  DateTime? deliveryDate;
  final TextEditingController orderDateController = TextEditingController();
  final TextEditingController deliveryDateController = TextEditingController();
  final TextEditingController driverSearchController = TextEditingController();
  final TextEditingController customerSearchController =
      TextEditingController();
  final TextEditingController remarksController = TextEditingController();

  // Tax rate (5% as per image)
  final double taxRate = 0.05;

  final TextEditingController paymentController = TextEditingController();

  String? selectedPaymentMethod;

  List<String> paymentMethods = ["Cash", "Card", "UPI", "Online"];

  bool isPaymentValid() {
    double entered = double.tryParse(paymentController.text) ?? 0;
    return entered <= getGrossTotal();
  }

  @override
  void initState() {
    super.initState();
    localCart = List.from(widget.cartItems);
    discountPercentage = widget.initialDiscount;
    orderDateController.text = _formatDate(orderDate);
    fetchAddons();
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
  }

  Future<void> _selectDate(BuildContext context, bool isOrderDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isOrderDate ? orderDate : (deliveryDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isOrderDate) {
          orderDate = picked;
          orderDateController.text = _formatDate(picked);
        } else {
          deliveryDate = picked;
          deliveryDateController.text = _formatDate(picked);
        }
      });
    }
  }

  Future<void> fetchAddons() async {
    setState(() => isLoadingAddons = true);
    try {
      final dio = Dio();
      final response = await dio.get(
        '${ApiConfig.baseUrl}service/service_addon/list',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> addonsJson = response.data['data'];
        setState(() {
          availableAddons = addonsJson
              .map((json) => AddonModel.fromJson(json))
              .where((a) => a.status == 1)
              .toList();
          isLoadingAddons = false;
        });
      } else {
        setState(() => isLoadingAddons = false);
      }
    } catch (e) {
      setState(() => isLoadingAddons = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error loading addons: $e')));
    }
  }

  // Cart operations
  void increaseQty(int index) => setState(() => localCart[index].quantity++);
  void decreaseQty(int index) {
    if (localCart[index].quantity > 1) {
      setState(() => localCart[index].quantity--);
    }
  }

  void deleteItem(int index) => setState(() => localCart.removeAt(index));

  // Calculations
  double getSubTotal() {
    return localCart.fold(0, (sum, item) => sum + item.price * item.quantity);
  }

  double getAddonPrice() => selectedAddon?.price ?? 0;

  double getTaxAmount() {
    return (getSubTotal() + getAddonPrice()) * taxRate;
  }

  double getDiscountAmount() {
    return (getSubTotal() + getAddonPrice()) * (discountPercentage / 100);
  }

  double getGrossTotal() {
    return getSubTotal() +
        getAddonPrice() +
        getTaxAmount() -
        getDiscountAmount();
  }

  // Discount dialog
  void _showDiscountDialog() {
    TextEditingController controller = TextEditingController(
      text: discountPercentage.toString(),
    );
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Add Discount"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: "e.g. 5",
            suffixText: "%",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                discountPercentage = double.tryParse(controller.text) ?? 0;
              });
              Navigator.pop(ctx);
            },
            child: const Text("Apply"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: Column(
          children: [
            // Blue header
            Container(
              height: 120,
              padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
              decoration: const BoxDecoration(
                color: Color(0xFF3F6CC9),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
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

            // Main scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    // Order date & delivery date row
                    Row(
                      children: [
                        Expanded(
                          child: _buildDateField(
                            label: "ORDER DATE",
                            controller: orderDateController,
                            onTap: () => _selectDate(context, true),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildDateField(
                            label: "DELIVERY DATE",
                            controller: deliveryDateController,
                            onTap: () => _selectDate(context, false),
                            hint: "Select date",
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Search driver & customer row
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: _buildSearchField(
                    //         label: "Search driver",
                    //         controller: driverSearchController,
                    //       ),
                    //     ),
                    //     const SizedBox(width: 12),
                    //     Expanded(
                    //       child: _buildSearchField(
                    //         label: "Search customer",
                    //         controller: customerSearchController,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 16),

                    // Customer card (from original)
                    Container(
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
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.customer.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.customer.type,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.customer.mobileNo,
                                  style: const TextStyle(fontSize: 12),
                                ),
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

                    const SizedBox(height: 16),

                    // Add service item button (like in AddToMyCartScreen)
                    GestureDetector(
                      onTap: () => Navigator.pop(
                        context,
                      ), // Placeholder: go back to add items
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFB8C6EA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "+  Add Service Item",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Cart items list
                    if (localCart.isEmpty)
                      const Center(child: Text("No items in cart"))
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        style: const TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        "AED ${item.price.toStringAsFixed(2)}",
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

                    const SizedBox(height: 16),

                    // Order ID and Remarks
                    Container(
                      padding: const EdgeInsets.all(16),
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
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Order ID:",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "New Order",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 20),
                          TextField(
                            controller: remarksController,
                            decoration: const InputDecoration(
                              labelText: "Remarks",
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Addon dropdown
                    if (!isLoadingAddons && availableAddons.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.all(16),
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
                              "Addon",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(addon.name),
                                          Text(
                                            "AED ${addon.price.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF4845D2),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) =>
                                      setState(() => selectedAddon = newValue),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 16),

                    // Summary section (as per image)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xffEDE7F6),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          _buildSummaryRow(
                            "Sub Total:",
                            "AED ${getSubTotal().toStringAsFixed(2)}",
                          ),
                          if (selectedAddon != null)
                            _buildSummaryRow(
                              "  • ${selectedAddon!.name}",
                              "AED ${selectedAddon!.price.toStringAsFixed(2)}",
                              isAddon: true,
                            ),
                          _buildSummaryRow(
                            "Tax (5%):",
                            "AED ${getTaxAmount().toStringAsFixed(2)}",
                          ),
                          _buildSummaryRow(
                            "Discount %: ${discountPercentage.toStringAsFixed(0)}%",
                            "AED ${getDiscountAmount().toStringAsFixed(2)}",
                          ),
                          const Divider(height: 20, thickness: 1),
                          _buildSummaryRow(
                            "Gross Total:",
                            "AED ${getGrossTotal().toStringAsFixed(2)}",
                            isBold: true,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Discount apply button (from AddToMyCartScreen)
                    GestureDetector(
                      onTap: _showDiscountDialog,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFB8C6EA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Apply Discount",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// PAYMENT SECTION
                    Container(
                      padding: const EdgeInsets.all(16),
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
                        children: [
                          /// ENTER PAYMENT
                          TextField(
                            controller: paymentController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Enter Payment",
                              border: OutlineInputBorder(),
                              prefixText: "AED ",
                              errorText: isPaymentValid()
                                  ? null
                                  : "Payment exceeds total",
                            ),
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),

                          const SizedBox(height: 12),

                          /// PAYMENT METHOD DROPDOWN
                          DropdownButtonFormField<String>(
                            value: selectedPaymentMethod,
                            hint: const Text("Select Payment Method"),
                            items: paymentMethods.map((method) {
                              return DropdownMenuItem(
                                value: method,
                                child: Text(method),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedPaymentMethod = value;
                              });
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              if (!isPaymentValid()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Payment exceeds total"),
                                  ),
                                );
                                return;
                              }

                              if (selectedPaymentMethod == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Select payment method"),
                                  ),
                                );
                                return;
                              }

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderSuccessScreen(
                                    customerName: widget.customer.name,
                                  ),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: const BorderSide(color: Color(0xFFCDD2E1)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Save",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              //     Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => OrderSuccessScreen(
                              //       customerName: widget.customer.name,
                              //     ),
                              //   ),
                              // );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4845D2),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Print",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
    required VoidCallback onTap,
    String? hint,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  Text(
                    controller.text.isEmpty
                        ? (hint ?? "Select")
                        : controller.text,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const Icon(Icons.calendar_today, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField({
    required String label,
    required TextEditingController controller,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: label,
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          suffixIcon: const Icon(Icons.search, size: 20),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isBold = false,
    bool isAddon = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isAddon ? 12 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isAddon ? Colors.grey.shade600 : Colors.black,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              fontSize: isBold ? 16 : 14,
              color: isBold ? const Color(0xFF4845D2) : Colors.black,
            ),
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
