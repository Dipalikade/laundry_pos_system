import 'package:flutter/material.dart';
import 'package:laundry_pos_system_app/util/header.dart';


import 'customer_added_successfully_screen.dart';

class AddNewCustomerScreen extends StatefulWidget {
  const AddNewCustomerScreen({super.key});

  @override
  State<AddNewCustomerScreen> createState() =>
      _AddNewCustomerScreenState();
}

class _AddNewCustomerScreenState
    extends State<AddNewCustomerScreen> {

  bool isActive = false; // ✅ default OFF
  bool isWhatsappSame = false;

  final TextEditingController phoneController =
  TextEditingController();
  final TextEditingController whatsappController =
  TextEditingController();

  String? selectedCustomerType;
  String? selectedEmirates;
  String? selectedArea;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
        
            headerUi(title: "Add New Customer"),
            SizedBox(height: 10,),
        
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
        
                    /// TYPE
                    _label("Type of Customer", required: true),
                    const SizedBox(height: 6),
                    _dropdownField(
                      hint: "Choose Type",
                      value: selectedCustomerType,
                      items: const ["Regular", "VIP", "Corporate"],
                      onChanged: (val) {
                        setState(() {
                          selectedCustomerType = val;
                        });
                      },
                    ),
        
                    const SizedBox(height: 16),
        
                    /// NAME
                    _label("Customer Name", required: true),
                    const SizedBox(height: 6),
                    _textField("Customer Name"),
        
                    const SizedBox(height: 16),
        
                    /// PHONE
                    _label("Phone Number", required: true),
                    const SizedBox(height: 6),
                    _textField(
                      "**********",
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                    ),
        
                    const SizedBox(height: 12),
        
                    /// CHECKBOX
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
                        )
                      ],
                    ),
        
                    const SizedBox(height: 8),
        
                    /// WHATSAPP
                    _label("WhatsApp Number"),
                    const SizedBox(height: 6),
                    _textField(
                      "WhatsApp Number",
                      controller: whatsappController,
                      keyboardType: TextInputType.phone,
                    ),
        
                    const SizedBox(height: 16),
        
                    /// EMAIL
                    _label("Email"),
                    const SizedBox(height: 6),
                    _textField(
                      "Email",
                      keyboardType:
                      TextInputType.emailAddress,
                    ),
        
                    const SizedBox(height: 16),
        
                    /// EMIRATES
                    _label("Emirates", required: true),
                    const SizedBox(height: 6),
                    _dropdownField(
                      hint: "Choose Emirates",
                      value: selectedEmirates,
                      items: const [
                        "Dubai",
                        "Abu Dhabi",
                        "Sharjah"
                      ],
                      onChanged: (val) {
                        setState(() {
                          selectedEmirates = val;
                        });
                      },
                    ),
        
                    const SizedBox(height: 16),
        
                    /// AREA
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
        
                    _label("Apartment Number",),
                    const SizedBox(height: 6),
                    _textField("Apartment Number"),
        
                    const SizedBox(height: 16),
        
                    _label("Building Name",),
                    const SizedBox(height: 6),
                    _textField("Building Name"),
        
                    const SizedBox(height: 16),
        
                    _label("Location",),
                    const SizedBox(height: 6),
                    _textField("Location"),
        
                    /// TOGGLE
                    Row(
                      children: [
                        Switch(
                          value: isActive,
                          activeThumbColor:
                          const Color(0xff4FC3F7), // sky blue
                          onChanged: (val) {
                            setState(() {
                              isActive = val;
                            });
                          },
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          "Is Active?",
                          style: TextStyle(
                              fontWeight:
                              FontWeight.w500),
                        )
                      ],
                    ),
        
                    const SizedBox(height: 24),
        
                    /// SAVE BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>CustomerAddedSuccessScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color(0xFF4845D2),
                          padding:
                          const EdgeInsets.symmetric(
                              vertical: 15),
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Save Customer",
                          style: TextStyle(
                              fontWeight:
                              FontWeight.w600,
                              fontSize: 15,
                              color: Colors.white),
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

  /// 🔹 LABEL WITH RED STAR
  Widget _label(String text,
      {bool required = false}) {
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

  /// 🔹 TEXT FIELD
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
        hintStyle:
        const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(
            horizontal: 12, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: Colors.grey),
        ),
      ),
    );
  }

  /// 🔹 DROPDOWN
  Widget _dropdownField({
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(10),
        border:
        Border.all(color: Colors.grey),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(
            hint,
            style: const TextStyle(
                color: Colors.grey),
          ),
          value: value,
          isExpanded: true,
          items: items
              .map((e) =>
              DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

