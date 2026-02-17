import 'package:flutter/material.dart';

import '../../util/header.dart';
class SelectPaymentMethodUpperPartUtil extends StatefulWidget {
  const SelectPaymentMethodUpperPartUtil({super.key});

  @override
  State<SelectPaymentMethodUpperPartUtil> createState() => _SelectPaymentMethodUpperPartUtilState();
}

class _SelectPaymentMethodUpperPartUtilState extends State<SelectPaymentMethodUpperPartUtil> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [

          // 🔵 Top Header
          headerUi(title: "Today's Collection"),

          const SizedBox(height: 15),

          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 10),
                        Text(
                          "Search Collection",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Color(0xFF6C8BEF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.filter_alt_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 📄 Collection Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFE8E6F2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "#TMS/COL-01",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.person,size: 15,color: Colors.grey,),
                          SizedBox(width: 5,),
                          Text("John Doe"),
                        ],
                      ),

                      SizedBox(height: 4),

                      Row(
                        children: [
                          Icon(Icons.phone,size: 15,color: Colors.grey,),
                          SizedBox(width: 5,),
                          Text(
                            "9876543201",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),

                      SizedBox(height: 4),

                      Row(
                        children: [
                          Icon(Icons.add_box_outlined,size: 15,color: Colors.grey,),
                          SizedBox(width: 5,),
                          Text(
                            "Payment",
                            style: TextStyle(color: Colors.grey,),
                          ),
                        ],
                      )

                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                              height: 50,
                              width: 50,
                              child: Image.asset("assets/images/payment_collection.png",fit: BoxFit.cover)),

                          const SizedBox(width: 5),

                        ],
                      ),
                      SizedBox(width: 10,),
                      Column(
                        children: [
                          const Text(
                            "Outstanding\nAmount",
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(color: Color(0xFFB0668D), fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "AED 850.00",
                            style: TextStyle(
                              color: Color(0xFFB0668D),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],);
    }
}
