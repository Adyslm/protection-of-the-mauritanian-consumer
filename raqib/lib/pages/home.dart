
import 'package:flutter/material.dart';

class Hame_Page extends StatelessWidget {
  const Hame_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Text("home page kjlkljlkjdskljfk", style: TextStyle(
                    fontSize: 14,
                    fontWeight:FontWeight.bold
                  ),),
                ],
              ),
            ),
          ),
        ),
      );
  }
}