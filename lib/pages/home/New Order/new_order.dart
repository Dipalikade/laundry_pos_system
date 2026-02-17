import 'package:flutter/material.dart';
import 'package:laundry_pos_system_app/util/header.dart';
import '../../../model/customer_model.dart';
import 'add_customer_screen.dart';
import 'create_order_screen.dart';

class CustomerListBody extends StatefulWidget {
  const CustomerListBody({super.key});

  @override
  State<CustomerListBody> createState() => _CustomerListBodyState();
}

class _CustomerListBodyState extends State<CustomerListBody> {
  String selectedTab = "All";

  // ✅ Dummy Customer List (Now using Model)
  final List<Customer> customers = [
    Customer(
      name: "John Doe",
      type: "Individual",
      phone: "9876543201",
      address: "Marina Pinnacle, Dubai",
      email:"john.doe@example.com"
    ),
    Customer(
      name: "Sarah Khan",
      type: "Corporate",
      phone: "9876543210",
      address: "Business Bay, Dubai",
        email:"john.doe@example.com"
    ),
    Customer(
      name: "Ahmed Ali",
      type: "Individual",
      phone: "9876543222",
      address: "Downtown Dubai",
        email:"john.doe@example.com"
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // ✅ Filter Logic
    final List<Customer> filteredCustomers = selectedTab == "All"
        ? customers
        : customers
        .where((customer) => customer.type == selectedTab)
        .toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            headerUi(title: "Customers"),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // 🔍 Search bar + Add button
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search Customer Here",
                            prefixIcon: const Icon(Icons.search),
                            contentPadding:
                            const EdgeInsets.symmetric(vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6884EA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const AddNewCustomerScreen(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.person_add,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 12),

                  // 🔘 Filter Tabs
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        _filterTab("All"),
                        _filterTab("Individual"),
                        _filterTab("Corporate"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ✅ Dynamic List
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  itemCount: filteredCustomers.length,
                  itemBuilder: (context, index) {
                    return CustomerCard(
                      customer: filteredCustomers[index],
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

  Widget _filterTab(String title) {
    final bool isActive = selectedTab == title;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = title;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF6C8CF5) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomerCard extends StatelessWidget {
  final Customer customer;

  const CustomerCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    final bool isIndividual = customer.type == "Individual";

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CreateOrderScreen(customer: customer),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xFFF5F1FD),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(
                        customer.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.phone,
                          size: 14, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(
                        customer.phone,
                        style:
                        const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 14, color: Colors.grey),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          customer.address,
                          style:
                          const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isIndividual
                        ? const Color(0xFFF6E2B8)
                        : const Color(0xFFCCE8E2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    customer.type,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 10),
            const Icon(Icons.arrow_forward_ios, size: 14),
          ],
        ),
      ),
    );
  }
}
