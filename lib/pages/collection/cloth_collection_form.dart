import 'package:flutter/material.dart';

enum Meridiem { am, pm }

class ClothCollectionForm extends StatefulWidget {
  const ClothCollectionForm({super.key});

  @override
  State<ClothCollectionForm> createState() => _ClothCollectionFormState();
}

class _ClothCollectionFormState extends State<ClothCollectionForm> {
  final _formKey = GlobalKey<FormState>();

  String? customerType;
  String? customer;
  String? driver;
  DateTime? pickupDate;
  Meridiem meridiem = Meridiem.am;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController hourController = TextEditingController();

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() => pickupDate = picked);
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
              _label("Customer Type"),
              _dropdown(
                value: customerType,
                hint: "Choose Type",
                items: const ["Regular", "Premium"],
                onChanged: (v) => setState(() => customerType = v),
              ),

              _label("Customer"),
              _dropdown(
                value: customer,
                hint: "Choose Customer",
                items: const [
                  "Choose Customer",
                  "test",
                  "as laundary",
                  "mohomaad",
                ],
                onChanged: (v) => setState(() => customer = v),
              ),

              const SizedBox(height: 12),

              _label("Pick Up Date"),
              _dateField(),

              const SizedBox(height: 12),

              _label("Time Slot"),
              _timeSlot(),

              _label("Phone Number"),
              _inputField(
                controller: phoneController,
                hint: "**********",
                keyboardType: TextInputType.phone,
                validator: (v) =>
                v!.length < 10 ? "Enter valid phone number" : null,
              ),

              _label("Driver"),
              _dropdown(
                value: driver,
                hint: "Choose Driver",
                items: const ["Driver 1", "Driver 2"],
                onChanged: (v) => setState(() => driver = v),
              ),

              _label("Comments"),
              _inputField(
                controller: commentController,
                hint: "Enter Comments",
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
                        pickupDate != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Saved successfully")),
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

  Widget _dropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      hint: Text(hint),
      decoration: _decoration(),
      items: items
          .map(
            (e) => DropdownMenuItem(
          value: e,
          child: Text(e),
        ),
      )
          .toList(),
      validator: (v) => v == null ? "Required" : null,
      onChanged: onChanged,
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator ??
              (v) => v == null || v.isEmpty ? "Required" : null,
      decoration: _decoration(hint: hint),
    );
  }

  Widget _dateField() {
    return GestureDetector(
      onTap: _selectDate,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: _boxDecoration(),
        child: Row(
          children: [
            Expanded(
              child: Text(
                pickupDate == null
                    ? "Select date"
                    : "${pickupDate!.day}/${pickupDate!.month}/${pickupDate!.year}",
                style: TextStyle(
                  color:
                  pickupDate == null ? Colors.grey : Colors.black,
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
              if (h == null || h < 1 || h > 12) {
                return "1–12";
              }
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
          child: const Text(
            "00",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Row(
            children: [
              _ampmButton(Meridiem.am, "AM"),
              const SizedBox(width: 6),
              _ampmButton(Meridiem.pm, "PM"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _ampmButton(Meridiem value, String text) {
    final selected = meridiem == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => meridiem = value),
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