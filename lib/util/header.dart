import 'package:flutter/material.dart';
class headerUi extends StatefulWidget {
  final String title;
  const headerUi({super.key,required this.title});

  // heder file 

  @override
  State<headerUi> createState() => _headerUiState();

  // this is dipali code
}

class _headerUiState extends State<headerUi> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(15),
              height: 95,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(0xFF3067C6),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
              ),
              child: Row(
                children: [
                  Text(widget.title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
                  Spacer(),
                  Icon(Icons.notifications,color: Colors.white,)
                ],
              )
          ),
          // SizedBox(height: 10,)
        ],
      ),
    );
  }
}
