import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_pos_system_app/model/customer_model.dart';
import 'package:laundry_pos_system_app/providers/customer_provider.dart';
import 'package:laundry_pos_system_app/util/header.dart';
import '../../../providers/emirates_provider.dart';
import '../../../providers/areas_provider.dart';
import 'new_order.dart';


class AddNewCustomerScreen extends ConsumerStatefulWidget {
  const AddNewCustomerScreen({super.key});

  @override
  ConsumerState<AddNewCustomerScreen> createState() =>
      _AddNewCustomerScreenState();
}

class _AddNewCustomerScreenState
    extends ConsumerState<AddNewCustomerScreen> {
  bool isActive = false;
  bool isWhatsappSame = false;

  final _formKey = GlobalKey<FormState>();

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

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final customerState = ref.watch(customerProvider);
    final emiratesAsync = ref.watch(emiratesProvider);
    final areasAsync = ref.watch(areasProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            headerUi(title: "Add New Customer"),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Form(
                  key: _formKey,
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
                      _textField(
                        "Customer Name",
                        controller: nameController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Customer name is required";
                            }

                            if (value.trim().length < 3) {
                              return "Name must be at least 3 characters";
                            }

                            final nameRegex = RegExp(r'^[a-zA-Z ]+$');
                            if (!nameRegex.hasMatch(value.trim())) {
                              return "Name should contain only letters";
                            }

                            return null;
                          },
                      ),

                      const SizedBox(height: 16),

                      _label("Phone Number", required: true),
                      const SizedBox(height: 6),
                      _textField(
                        "**********",
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Phone number is required";
                            }

                            final phone = value.trim();

                            if (!RegExp(r'^\d{10}$').hasMatch(phone)) {
                              return "Phone number must be exactly 10 digits";
                            }

                            return null;
                          },
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
                                  whatsappController.text =
                                      phoneController.text;
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
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return null; // optional field
                          }

                          final emailRegex = RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          );

                          if (!emailRegex.hasMatch(value.trim())) {
                            return "Enter valid email address";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      _label("Emirates", required: true),
                      const SizedBox(height: 6),
                      emiratesAsync.when(
                        loading: () =>
                        const Center(child: CircularProgressIndicator()),
                        error: (err, _) => Text("Error: $err"),
                        data: (emiratesList) {
                          return _dropdownField(
                            hint: "Choose Emirates",
                            value: selectedEmirates,
                            items: emiratesList
                                .map((e) => e.emirate)
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                selectedEmirates = val;
                              });
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 16),

                      _label("Area", required: true),
                      const SizedBox(height: 6),
                      areasAsync.when(
                        loading: () =>
                        const Center(child: CircularProgressIndicator()),
                        error: (err, _) => Text("Error: $err"),
                        data: (areasList) {
                          return _dropdownField(
                            hint: "Choose Area",
                            value: selectedArea,
                            items:
                            areasList.map((e) => e.area).toList(),
                            onChanged: (val) {
                              setState(() {
                                selectedArea = val;
                              });
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 18),

                      _label("Apartment Number"),
                      const SizedBox(height: 6),
                      _textField("Apartment Number",
                          controller: apartmentController),

                      const SizedBox(height: 16),

                      _label("Building Name"),
                      const SizedBox(height: 6),
                      _textField("Building Name",
                          controller: buildingController),

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
                            // ✅ validate text fields
                            if (!_formKey.currentState!.validate()) return;

                            // ✅ validate dropdowns
                            if (selectedCustomerType == null) {
                              _showSnack("Please select customer type");
                              return;
                            }

                            if (selectedEmirates == null) {
                              _showSnack("Please select emirates");
                              return;
                            }

                            if (selectedArea == null) {
                              _showSnack("Please select area");
                              return;
                            }

                            final customer = Customer(
                              name: nameController.text.trim(),
                              type: selectedCustomerType!.toLowerCase(),
                              mobileNo: phoneController.text.trim(),
                              whatsappNo:
                              whatsappController.text.trim(),
                              email: emailController.text.trim(),
                              emirates: selectedEmirates!,
                              area: selectedArea!,
                              apartmentNumber:
                              apartmentController.text.trim(),
                              buildingName:
                              buildingController.text.trim(),
                              mapLocation:
                              locationController.text.trim(),
                              taxNumber: taxController.text.trim(),
                              address: addressController.text.trim(),
                              status: isActive ? 1 : 0,
                            );

                            await ref
                                .read(customerProvider.notifier)
                                .addCustomer(customer);

                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Customer created successfully"),
                                  backgroundColor: Colors.green,
                                ),
                              );

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                  const CustomerListBody(),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4845D2),
                            padding:
                            const EdgeInsets.symmetric(vertical: 15),
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
        String? Function(String?)? validator,
      }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }

  Widget _dropdownField({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
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