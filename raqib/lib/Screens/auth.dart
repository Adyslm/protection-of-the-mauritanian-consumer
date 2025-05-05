import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:raqib/Screens/otp.dart';
import 'package:raqib/Screens/register_screen.dart';
// import 'package:raqib/Screens/register_screen.dart';
import 'package:raqib/Services/auth_services.dart';
// import 'package:raqib/Services/globals.dart';

class Auth_Screen extends StatefulWidget {
  const Auth_Screen({Key? key}) : super(key: key);

  @override
  _Auth_ScreenState createState() => _Auth_ScreenState();
}

class _Auth_ScreenState extends State<Auth_Screen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _phone_num = '';

  Future<void> _verify() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final response = await AuthServices.verify(_name, _phone_num);

      print(
        "Full server response: ${response.body}",
      ); // Print the *entire* response

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        //==========================================================================================================
        // Registration was successful
        print("Registration successful! Response Data: $responseData");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OPT_Page(),
            settings: RouteSettings(
              arguments: {'phoneNumber': _phone_num, 'name': _name},
            ),
          ),
        );
      } else {
        // Registration failed, handle errors from backend
        print("Verification failed! Response Data: $responseData");
        String errorMessage = 'Verification failed'; // Default message

        if (responseData is Map<String, dynamic>) {
          if (responseData.containsKey('errors')) {
            final errors = responseData['errors'] as Map<String, dynamic>;
            if (errors.isNotEmpty) {
              errorMessage = errors.values.first[0].toString();
            }
          } else if (responseData.containsKey('message')) {
            errorMessage = responseData['message'].toString();
          }
        }
        _showErrorDialog(errorMessage); //show the error
      }
    } catch (e) {
      // Handle network errors or exceptions during the process
      print("Error during registration: $e");
      _showErrorDialog('Registration error: ${e.toString()}');
    }
  }

  // Function to show an error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Verification')),
      backgroundColor: Color.fromRGBO(240, 248, 235, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  // NAME FIELD
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Full Name', // Changed label text
                      prefixIcon: Icon(
                        Icons.contact_emergency,
                      ), // Kept the phone icon
                      border: OutlineInputBorder(
                        // Added OutlineInputBorder
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ), // Rounded corners
                      ),
                      filled: true, // Added filled property
                      fillColor: Colors.white, // Set fill color to white
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 16.0,
                      ), // Added padding
                    ),
                    validator: (value) {
                      if (value == null || value.length < 3) {
                        return 'Name must be at least 3 characters';
                      }
                      return null;
                    },
                    onChanged: (value) => _name = value,
                  ),
                  const SizedBox(height: 15),

                  // PHONE NUMBER FIELD
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number', // Changed label text
                      prefixIcon: Icon(Icons.call), // Kept the phone icon
                      border: OutlineInputBorder(
                        // Added OutlineInputBorder
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ), // Rounded corners
                      ),
                      filled: true, // Added filled property
                      fillColor: Colors.white, // Set fill color to white
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 16.0,
                      ), // Added padding
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null ||
                          value.length < 8 ||
                          !RegExp(r'^[0-9]{8,}$').hasMatch(value)) {
                        return 'Phone must be at least 8 digits';
                      }
                      return null;
                    },
                    onChanged: (value) => _phone_num = value,
                  ),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: _verify,
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 40.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
