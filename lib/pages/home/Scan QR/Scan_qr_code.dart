import 'package:flutter/material.dart';

import 'order_details_view.dart';

class ScanInvoiceQRScreen extends StatefulWidget {
  const ScanInvoiceQRScreen({super.key});

  @override
  State<ScanInvoiceQRScreen> createState() => _ScanInvoiceQRScreenState();
}

class _ScanInvoiceQRScreenState extends State<ScanInvoiceQRScreen> {

  @override
  void initState() {
    super.initState();

    /// 🔥 Navigate after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OrderDetailsView(), // 👈 Change this
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6D4C41),
      body: SafeArea(
        child: Stack(
          children: [

            /// 🔹 HEADER
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  height: 95,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF3067C6),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back,
                          color: Colors.white, size: 23),
                      SizedBox(width: 10),
                      Text(
                        "Scan Invoice QR",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            /// 🔹 CENTER CONTENT
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  SizedBox(
                    width: 260,
                    height: 260,
                    child: Stack(
                      children: [

                        Center(
                          child: Image.asset(
                            "assets/images/QR.png",
                            width: 150,
                            height: 150,
                          ),
                        ),

                        Positioned.fill(
                          child: CustomPaint(
                            painter: ScannerCornerPainter(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Scan QR code",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),

            /// 🔹 BOTTOM BUTTON
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 22, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.photo,
                          color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text(
                        "Scan from photo",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      )
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
}

/// 🔹 NEXT SCREEN (Replace With Your Actual Screen)
class NextScreen extends StatelessWidget {
  const NextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Next Screen",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}

/// 🔹 SCANNER CORNERS
class ScannerCornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double cornerLength = 35;
    const double strokeWidth = 4;

    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawLine(const Offset(0, 0),
        const Offset(cornerLength, 0), paint);
    canvas.drawLine(const Offset(0, 0),
        const Offset(0, cornerLength), paint);

    canvas.drawLine(
        Offset(size.width, 0),
        Offset(size.width - cornerLength, 0),
        paint);
    canvas.drawLine(
        Offset(size.width, 0),
        Offset(size.width, cornerLength),
        paint);

    canvas.drawLine(
        Offset(0, size.height),
        Offset(cornerLength, size.height),
        paint);
    canvas.drawLine(
        Offset(0, size.height),
        Offset(0, size.height - cornerLength),
        paint);

    canvas.drawLine(
        Offset(size.width, size.height),
        Offset(size.width - cornerLength, size.height),
        paint);
    canvas.drawLine(
        Offset(size.width, size.height),
        Offset(size.width, size.height - cornerLength),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}