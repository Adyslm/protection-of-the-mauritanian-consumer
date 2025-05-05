import 'package:flutter/material.dart';

class Personal extends StatelessWidget {
  const Personal({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text("Personal Screen")
          ],
        ),
      ),
    );
  }
}