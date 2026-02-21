import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/customer_provider.dart';
import '../../providers/driver_provider.dart';
import '../../providers/create_collection_provider.dart'; // ✅ ADDED

enum Meridiem { am, pm }

class ClothCollectionForm extends ConsumerStatefulWidget {
  const ClothCollectionForm({super.key});

  @override
  ConsumerState<ClothCollectionForm> createState() =>
      _ClothCollectionFormState();
}

class _ClothCollectionFormState
    extends ConsumerState<ClothCollectionForm> {
  final _formKey = GlobalKey<FormState>();

  String? selectedHour;

  String searchText = "";
  String? selectedCustomerId;
  String? selectedCustomerName;

  String? customerType;
  String? driver;
  DateTime? pickupDate;
  Meridiem meridiem = Meridiem.am;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  Timer? _debounce;

  void _updateTimeController() {
    if (selectedHour != null) {
      final period = meridiem == Meridiem.am ? "AM" : "PM";
      hourController.text = "$selectedHour:00 $period";
    }
  }

  void _openCustomerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return SafeArea(
              child: Consumer(
                builder: (context, ref, _) {
                  final customersAsync =
                  ref.watch(customersListProvider(searchText));

                  return Padding(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 4,
                          width: 40,
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        TextField(
                          controller: searchController,
                          decoration: const InputDecoration(
                            hintText: "Search Customer",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            if (_debounce?.isActive ?? false) {
                              _debounce!.cancel();
                            }

                            _debounce = Timer(
                              const Duration(milliseconds: 400),
                                  () {
                                setState(() {
                                  searchText = value;
                                });
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 15),

                        Expanded(
                          child: customersAsync.when(
                            loading: () => const Center(
                                child: CircularProgressIndicator()),
                            error: (e, _) =>
                                Center(child: Text("Error: $e")),
                            data: (customers) {
                              if (customers.isEmpty) {
                                return const Center(
                                  child: Text("No customers found"),
                                );
                              }

                              return ListView.builder(
                                controller: scrollController,
                                itemCount: customers.length,
                                itemBuilder: (context, index) {
                                  final customer = customers[index];

                                  return ListTile(
                                    title: Text(customer.name),
                                    onTap: () {
                                      setState(() {
                                        selectedCustomerId =
                                            customer.id.toString();
                                        selectedCustomerName =
                                            customer.name;
                                        phoneController.text =
                                            customer.mobileNo ?? "";
                                      });

                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

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
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    phoneController.dispose();
    commentController.dispose();
    hourController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label("Customer Type"),
              _dropdown(
                value: customerType,
                hint: "Choose Type",
                items: const ["Individual", "Corporate"],
                onChanged: (v) => setState(() => customerType = v),
              ),

              const SizedBox(height: 10),

              _label("Customer"),
              GestureDetector(
                onTap: () => _openCustomerBottomSheet(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Choose Customer",
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.arrow_drop_down),
                    ),
                    controller: TextEditingController(
                      text: selectedCustomerName ?? "",
                    ),
                  ),
                ),
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
              Consumer(
                builder: (context, ref, _) {
                  final driversAsync = ref.watch(driversProvider);

                  return driversAsync.when(
                    loading: () =>
                    const CircularProgressIndicator(),
                    error: (e, _) => Text("Error: $e"),
                    data: (drivers) {
                      return DropdownButtonFormField<String>(
                        value: driver, // ✅ FIXED
                        hint: const Text("Choose Driver"),
                        decoration: _decoration(),
                        items: drivers.map((d) {
                          return DropdownMenuItem<String>(
                            value: d.id.toString(),
                            child: Text(d.fullName),
                          );
                        }).toList(),
                        validator: (v) =>
                        v == null ? "Required" : null,
                        onChanged: (value) {
                          setState(() {
                            driver = value;
                          });
                        },
                      );
                    },
                  );
                },
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
                    backgroundColor:
                    const Color(0xFF6F93E8),
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState!.validate() ||
                        pickupDate == null ||
                        selectedCustomerId == null ||
                        driver == null) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Please fill all required fields"),
                        ),
                      );
                      return;
                    }

                    final body = {
                      "collection_type": "CLOTH",
                      "customer_type": customerType,
                      "customer_id":
                      int.parse(selectedCustomerId!),
                      "customer_name":
                      selectedCustomerName,
                      "pickup_date":
                      "${pickupDate!.year}-${pickupDate!.month.toString().padLeft(2, '0')}-${pickupDate!.day.toString().padLeft(2, '0')}",
                      "time_slot":
                      hourController.text,
                      "phone_number":
                      phoneController.text,
                      "driver_id":
                      int.parse(driver!),
                      "comments":
                      commentController.text,
                      "created_by": "Admin",
                    };

                    try {
                      final response = await ref.read(
                          createCollectionProvider(body)
                              .future);

                      if (response["success"] == true) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          SnackBar(
                            content:
                            Text(response["message"]),
                          ),
                        );

                        Navigator.pop(context);
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        SnackBar(
                            content:
                            Text(e.toString())),
                      );
                    }
                  },
                  child: const Text(
                    "Save",
                    style:
                    TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding:
      const EdgeInsets.only(bottom: 6, top: 12),
      child: Text(
        "$text *",
        style: const TextStyle(
            fontWeight: FontWeight.w600),
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
      value: value, // ✅ FIXED
      hint: Text(hint),
      decoration: _decoration(),
      items: items
          .map((e) => DropdownMenuItem(
          value: e, child: Text(e)))
          .toList(),
      validator: (v) =>
      v == null ? "Required" : null,
      onChanged: onChanged,
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType =
        TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator ??
              (v) => v == null || v.isEmpty
              ? "Required"
              : null,
      decoration: _decoration(hint: hint),
    );
  }

  Widget _dateField() {
    return GestureDetector(
      onTap: _selectDate,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(
            horizontal: 12),
        decoration: _boxDecoration(),
        child: Row(
          children: [
            Expanded(
              child: Text(
                pickupDate == null
                    ? "Select date"
                    : "${pickupDate!.day}/${pickupDate!.month}/${pickupDate!.year}",
                style: TextStyle(
                  color: pickupDate == null
                      ? Colors.grey
                      : Colors.black,
                ),
              ),
            ),
            const Icon(Icons.calendar_today,
                size: 16),
          ],
        ),
      ),
    );
  }

  Widget _timeSlot() {
    final hours = List.generate(12, (index) => (index + 1).toString());

    return Row(
      children: [
        /// Hour Dropdown
        Expanded(
          child: DropdownButtonFormField<String>(
            value: selectedHour,
            hint: const Text("Hour"),
            decoration: _decoration(),
            items: hours
                .map((h) => DropdownMenuItem(
              value: h,
              child: Text(h),
            ))
                .toList(),
            validator: (v) => v == null ? "Required" : null,
            onChanged: (value) {
              setState(() {
                selectedHour = value;
                _updateTimeController();
              });
            },
          ),
        ),

        const SizedBox(width: 12),

        /// AM / PM Dropdown
        Expanded(
          child: DropdownButtonFormField<Meridiem>(
            value: meridiem,
            decoration: _decoration(),
            items: const [
              DropdownMenuItem(
                value: Meridiem.am,
                child: Text("AM"),
              ),
              DropdownMenuItem(
                value: Meridiem.pm,
                child: Text("PM"),
              ),
            ],
            onChanged: (value) {
              setState(() {
                meridiem = value!;
                _updateTimeController();
              });
            },
          ),
        ),
      ],
    );
  }

  InputDecoration _decoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(8),
      ),
      contentPadding:
      const EdgeInsets.symmetric(
          horizontal: 12, vertical: 14),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      border: Border.all(
          color: Colors.grey.shade400),
      borderRadius:
      BorderRadius.circular(8),
    );
  }
}