import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_pos_system_app/model/customer_model.dart';
import 'package:laundry_pos_system_app/providers/customer_provider.dart';
import 'package:laundry_pos_system_app/util/header.dart';
import 'customer_added_successfully_screen.dart';

class AddNewCustomerScreen extends ConsumerStatefulWidget {
  const AddNewCustomerScreen({super.key});

  @override
  ConsumerState<AddNewCustomerScreen> createState() =>
      _AddNewCustomerScreenState();
}

class _AddNewCustomerScreenState extends ConsumerState<AddNewCustomerScreen> {
  bool isActive = false;
  bool isWhatsappSame = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController apartmentController = TextEditingController();
  final TextEditingController buildingController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController taxController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String? selectedCustomerType;
  String? selectedEmirates;
  String? selectedArea;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    whatsappController.dispose();
    emailController.dispose();
    apartmentController.dispose();
    buildingController.dispose();
    locationController.dispose();
    taxController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customerState = ref.watch(customerProvider);

    ref.listen(customerProvider, (previous, next) {
      next.when(
        data: (message) {
          if (message != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CustomerAddedSuccessScreen(),
              ),
            );
          }
        },
        error: (err, _) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(err.toString())));
        },
        loading: () {},
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            headerUi(title: "Add New Customer"),
            const SizedBox(height: 10),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label("Type of Customer", required: true),
                    const SizedBox(height: 6),
                    _dropdownField(
                      hint: "Choose Type",
                      value: selectedCustomerType,
                      items: const ["Individual", "Corporate"],
                      onChanged: (val) {
                        setState(() {
                          selectedCustomerType = val;
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    _label("Customer Name", required: true),
                    const SizedBox(height: 6),
                    _textField("Customer Name", controller: nameController),

                    const SizedBox(height: 16),

                    _label("Phone Number", required: true),
                    const SizedBox(height: 6),
                    _textField(
                      "**********",
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Checkbox(
                          value: isWhatsappSame,
                          activeColor: const Color(0xff4FC3F7),
                          onChanged: (val) {
                            setState(() {
                              isWhatsappSame = val!;
                              if (isWhatsappSame) {
                                whatsappController.text = phoneController.text;
                              } else {
                                whatsappController.clear();
                              }
                            });
                          },
                        ),
                        const Expanded(
                          child: Text(
                            "WhatsApp Number Same as Phone Number?",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    _label("WhatsApp Number"),
                    const SizedBox(height: 6),
                    _textField(
                      "WhatsApp Number",
                      controller: whatsappController,
                      keyboardType: TextInputType.phone,
                    ),

                    const SizedBox(height: 16),

                    _label("Email"),
                    const SizedBox(height: 6),
                    _textField(
                      "Email",
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 16),

                    _label("Emirates", required: true),
                    const SizedBox(height: 6),
                    _dropdownField(
                      hint: "Choose Emirates",
                      value: selectedEmirates,
                      items: const ["Dubai", "Abu Dhabi", "Sharjah"],
                      onChanged: (val) {
                        setState(() {
                          selectedEmirates = val;
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    _label("Area", required: true),
                    const SizedBox(height: 6),
                    _dropdownField(
                      hint: "Choose Area",
                      value: selectedArea,
                      items: const ["Marina", "JLT", "Downtown"],
                      onChanged: (val) {
                        setState(() {
                          selectedArea = val;
                        });
                      },
                    ),

                    const SizedBox(height: 18),

                    _label("Apartment Number"),
                    const SizedBox(height: 6),
                    _textField(
                      "Apartment Number",
                      controller: apartmentController,
                    ),

                    const SizedBox(height: 16),

                    _label("Building Name"),
                    const SizedBox(height: 6),
                    _textField("Building Name", controller: buildingController),

                    const SizedBox(height: 16),

                    _label("Address"),
                    const SizedBox(height: 6),
                    _textField("Address", controller: addressController),

                    const SizedBox(height: 16),

                    _label("Location"),
                    const SizedBox(height: 6),
                    _textField("Location", controller: locationController),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Switch(
                          value: isActive,
                          activeThumbColor: const Color(0xff4FC3F7),
                          onChanged: (val) {
                            setState(() {
                              isActive = val;
                            });
                          },
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          "Is Active?",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: customerState is AsyncLoading
                            ? null
                            : () async {
                                final customer = Customer(
                                  name: nameController.text.trim(),
                                  // ✅ FIXED CASE ISSUE HERE
                                  type: (selectedCustomerType ?? "Individual")
                                      .toLowerCase(),
                                  mobileNo: phoneController.text.trim(),
                                  whatsappNo: whatsappController.text.trim(),
                                  email: emailController.text.trim(),
                                  emirates: selectedEmirates ?? "",
                                  area: selectedArea ?? "",
                                  apartmentNumber: apartmentController.text
                                      .trim(),
                                  buildingName: buildingController.text.trim(),
                                  mapLocation: locationController.text.trim(),
                                  taxNumber: taxController.text.trim(),
                                  address: addressController.text.trim(),
                                  status: isActive ? 1 : 0,
                                );

                                await ref
                                    .read(customerProvider.notifier)
                                    .addCustomer(customer);
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4845D2),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: customerState is AsyncLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Save Customer",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text, {bool required = false}) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 13,
          color: Colors.black,
        ),
        children: [
          TextSpan(text: text),
          if (required)
            const TextSpan(
              text: " *",
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }

  Widget _textField(
    String hint, {
    TextEditingController? controller,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _dropdownField({
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(hint, style: const TextStyle(color: Colors.grey)),
          value: value,
          isExpanded: true,
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
