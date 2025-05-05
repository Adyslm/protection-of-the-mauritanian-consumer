import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OPtWidget extends StatelessWidget {
  final List<TextEditingController> controllers;
  
  const OPtWidget({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomFieldOTP(controller: controllers[0], first: true, last: false),
        CustomFieldOTP(controller: controllers[1], first: false, last: false),
        CustomFieldOTP(controller: controllers[2], first: false, last: false),
        CustomFieldOTP(controller: controllers[3], first: false, last: true),
      ],
    );
  }
}

class CustomFieldOTP extends StatelessWidget {
  final TextEditingController controller;
  final bool first;
  final bool last;
  
  const CustomFieldOTP({
    super.key,
    required this.controller,
    required this.first,
    required this.last,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      width: 60,
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          if (value.length == 1 && !last) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty && !first) {
            FocusScope.of(context).previousFocus();
          }
        },
        keyboardType: TextInputType.phone,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade100,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.deepPurpleAccent.shade100,
            )
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 232, 220, 244)
            )
          )
        ),
      ),
    );
  }
}