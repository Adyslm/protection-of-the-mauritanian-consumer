import 'package:flutter/material.dart';

class ChefNotification extends ChangeNotifier {
  String details = '';
  String moughataa = '';
  String address = '';
  String? imageBase64; // Stocker en base64

  void plainteNotification({
    required String details,
    required String moughataa,
    required String address,
    String? image,
  }) {
    this.details = details;
    this.moughataa = moughataa;
    this.address = address;
    this.imageBase64 = image;
    notifyListeners();
  }

  void updateImage(String? newImage) {
    imageBase64 = newImage;
    notifyListeners();
  }
}
