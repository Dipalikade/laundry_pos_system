import 'package:flutter/material.dart';

enum AmPm { am, pm }

class PaymentCollectionForm extends StatefulWidget {
  const PaymentCollectionForm({super.key});

  @override
  State<PaymentCollectionForm> createState() => _PaymentCollectionFormState();
}

class _PaymentCollectionFormState extends State<PaymentCollectionForm> {
  final _formKey = GlobalKey<FormState>();

  DateTime? selectedDate;
  AmPm selectedAmPm = AmPm.am;

  final TextEditingController hourController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  // 🔹 Dropdown data
  final List<String> customers = [
    "Ramesh Patel",
    "Amit Shah",
    "Neha Joshi",
  ];

  final List<String> drivers = [
    "Driver A",
    "Driver B",
    "Driver C",
  ];

  String? selectedCustomer;
  String? selectedDriver;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 16,right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label("Customer"),
              _dropdownField(
                hint: "Choose Customer",
                items: customers,
                value: selectedCustomer,
                onChanged: (v) => setState(() => selectedCustomer = v),
              ),

              _label("Phone Number"),
              _inputField(
                controller: phoneController,
                hint: "**********",
                keyboardType: TextInputType.phone,
              ),

              _label("Pick Up Date"),
              _dateField(),

              const SizedBox(height: 12),

              _label("Time Slot"),
              _timeSlot(),

              _label("Driver"),
              _dropdownField(
                hint: "Choose Driver",
                items: drivers,
                value: selectedDriver,
                onChanged: (v) => setState(() => selectedDriver = v),
              ),

              _label("Comments"),
              _inputField(
                controller: commentController,
                hint: "Enter comments",
                maxLines: 3,
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6F93E8),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        selectedDate != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Saved successfully"),
                        ),
                      );
                    }
                    Navigator.pop(context);
                  },
                  child: const Text("Save",style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- UI HELPERS ----------------

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 12),
      child: Text(
        "$text *",
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _dropdownField({
    required String hint,
    required List<String> items,
    required String? value,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down),
      decoration: _decoration(hint: hint),
      validator: (v) => v == null ? "Required" : null,
      items: items
          .map(
            (e) => DropdownMenuItem(
          value: e,
          child: Text(e),
        ),
      )
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: (v) => v == null || v.isEmpty ? "Required" : null,
      decoration: _decoration(hint: hint),
    );
  }

  Widget _dateField() {
    return GestureDetector(
      onTap: _pickDate,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: _boxDecoration(),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedDate == null
                    ? "Select date"
                    : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                style: TextStyle(
                  color:
                  selectedDate == null ? Colors.grey : Colors.black,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.calendar_today, size: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeSlot() {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: TextFormField(
            controller: hourController,
            keyboardType: TextInputType.number,
            decoration: _decoration(hint: "HH"),
            validator: (v) {
              if (v == null || v.isEmpty) return "Req";
              final h = int.tryParse(v);
              if (h == null || h < 1 || h > 12) return "1–12";
              return null;
            },
          ),
        ),
        const SizedBox(width: 6),
        const Text(":"),
        const SizedBox(width: 6),
        Container(
          width: 50,
          height: 48,
          alignment: Alignment.center,
          decoration: _boxDecoration(),
          child: const Text("00"),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Row(
            children: [
              _amPmButton(AmPm.am, "AM"),
              const SizedBox(width: 6),
              _amPmButton(AmPm.pm, "PM"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _amPmButton(AmPm value, String text) {
    final selected = selectedAmPm == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedAmPm = value),
        child: Container(
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF3067C6) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF3067C6)),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _decoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      border: Border.all(color: Colors.grey.shade400),
      borderRadius: BorderRadius.circular(8),
    );
  }
}