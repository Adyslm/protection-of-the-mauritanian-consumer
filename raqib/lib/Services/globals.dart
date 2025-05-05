import 'package:flutter/material.dart';

// Pour émulateur Android
const String baseURL = "http://192.168.100.43:8000/api/";
// Pour iOS simulator: "http://localhost:8000/api/"
// Pour appareil physique: "http://<votre-ip-locale>:8000/api/"

const Map<String, String> headers = {
  "Content-Type": "application/json",
  "Accept": "application/json",
};

void errorSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Text(text),
      duration: const Duration(seconds: 2),
    ),
  );
}

// 192.168.100.43