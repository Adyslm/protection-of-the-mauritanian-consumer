import 'package:flutter/material.dart';

class SavoirPlainte extends StatelessWidget {
  const SavoirPlainte({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0), // Increased height for curve
        child: ClipPath(
          clipper: CurvedBottomClipper(),
          child: Container(
            color: const Color.fromARGB(255, 45, 205, 9),
            child: const Center(
              child: Text(
                'الشكاوى',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}










class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40); // Start at bottom left
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 40); // Curve
    path.lineTo(size.width, 0); // Line to top right
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}