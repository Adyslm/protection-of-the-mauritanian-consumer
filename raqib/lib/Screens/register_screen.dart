// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:raqib/Screens/login_screen.dart';
// // import 'package:raqib/Screens/otp.dart';
// import 'package:raqib/Services/auth_services.dart';
// // import 'package:raqib/Services/globals.dart';

// class RegisterScreen extends StatefulWidget {
//   RegisterScreen({Key? key}) : super(key: key);

//   @override
//   validateUserScreenState createState() => validateUserScreenState();
// }

// class validateUserScreenState extends State<RegisterScreen> {
//   final _formKey = GlobalKey<FormState>();
//   bool _obscureText = true;
//   bool _obscureText1 = true;
//   String _name = '';
//   String _NNI = '';
//   String _phone_num = '';
//   String _password = '';
//   String _confirmPassword = '';
//   String _role = 'citoyen';

//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) => _loadInitialData());
//   }

//   void _loadInitialData() {
//     final args =
//         ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

//     if (args != null) {
//       setState(() {
//         _name = args['name'] ?? '';
//         _phone_num = args['phoneNumber'] ?? '';
//       });
//     }
//   }

//   Future<void> validateUser() async {
//     if (!_formKey.currentState!.validate()) return;
//     print(
//       "Données envoyées : {"
//       "name: $_name, "
//       "NNI: $_NNI, "
//       "phone: $_phone_num, "
//       "password: $_password, "
//       "role: $_role"
//       "}",
//     );

//     try {
//       final response = await AuthServices.validateUser(
//         _name,
//         _NNI,
//         _phone_num,
//         _password,
//         _role,
//       );

//       print(
//         "Full server response: ${response.body}",
//       ); // Print the *entire* response

//       final responseData = json.decode(response.body);

//       if (response.statusCode == 200) {
//         // Registration was successful
//         print("Registration successful! Response Data: $responseData");
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => LoginScreen(),
//             // settings: RouteSettings(arguments: _phone_num),
//           ),
//         );
//       } else {
//         // Registration failed, handle errors from backend
//         print("Registration failed! Response Data: $responseData");
//         String errorMessage = 'Registration failed';

//         if (responseData is Map<String, dynamic>) {
//           if (responseData.containsKey('errors')) {
//             final errors = responseData['errors'] as Map<String, dynamic>;
//             if (errors.isNotEmpty) {
//               errorMessage = errors.values.first[0].toString();
//             }
//           } else if (responseData.containsKey('message')) {
//             errorMessage = responseData['message'].toString();
//           }
//         }
//         _showErrorDialog(errorMessage); //show the error
//       }
//     } catch (e) {
//       // Handle network errors or exceptions during the process
//       print("Error during registration: $e");
//       _showErrorDialog('Registration error: ${e.toString()}');
//     }
//   }

//   // Function to show an error dialog
//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Error'),
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(240, 248, 235, 1),
//       // appBar: AppBar(title: const Text('Register')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 // Name FIELD
//                 TextFormField(
//                   decoration: const InputDecoration(
//                     // labelText: 'name',
//                   ),
//                   keyboardType: TextInputType.number,
//                   initialValue: _name,
//                   enabled: false,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.digitsOnly,
//                     LengthLimitingTextInputFormatter(10),
//                   ],
//                   onChanged: (value) => _name = value,
//                 ),
//                 SizedBox(height: 80),

//                 // NNI FIELD
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'NNI (10 digits)',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     filled: true,
//                     fillColor: Colors.white,
//                     prefixIcon: Icon(Icons.app_registration_rounded),
//                   ),
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.digitsOnly,
//                     LengthLimitingTextInputFormatter(10),
//                   ],
//                   validator: (value) {
//                     if (value == null ||
//                         value.length != 10 ||
//                         !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
//                       return 'NNI must be exactly 10 digits';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) => _NNI = value,
//                 ),

//                 SizedBox(height: 15),

//                 // PASSWORD FIELD
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     filled: true,
//                     fillColor: Colors.white,
//                     prefixIcon: Icon(Icons.lock),
//                     suffixIcon: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _obscureText = !_obscureText;
//                         });
//                       },
//                       child: Icon(
//                         _obscureText ? Icons.visibility_off : Icons.visibility,
//                       ),
//                     ),
//                   ),
//                   obscureText: _obscureText,
//                   keyboardType: TextInputType.phone,
//                   validator: (value) {
//                     if (value == null || value.length < 4) {
//                       return 'Password must be at least 4 characters';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) => _password = value,
//                 ),
//                 const SizedBox(height: 15),
//                 // CONFIRM PASSWORD FIELD
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Repeat the password',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     filled: true,
//                     fillColor: Colors.white,
//                     prefixIcon: Icon(Icons.lock),
//                     suffixIcon: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _obscureText = !_obscureText1;
//                         });
//                       },
//                       child: Icon(
//                         _obscureText ? Icons.visibility_off : Icons.visibility,
//                       ),
//                     ),
//                   ),
//                   obscureText: _obscureText,
//                   keyboardType: TextInputType.phone,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Confirm your password';
//                     }
//                     if (value != _password) {
//                       return 'Passwords do not match';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) => _confirmPassword = value,
//                 ),
//                 const SizedBox(height: 19),

//                 // PHONE NUMBER FIELD
//                 TextFormField(
//                   decoration: const InputDecoration(
//                     // labelText: 'Phone number'
//                   ),
//                   keyboardType: TextInputType.number,
//                   initialValue: _phone_num,
//                   enabled: false,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.digitsOnly,
//                     LengthLimitingTextInputFormatter(10),
//                   ],
//                   onChanged: (value) => _phone_num = value,
//                 ),
//                 // ROLE SELECTION DROPDOWN
//                 RoleDropdown(
//                   initialRole: _role,
//                   onRoleSelected: (String? role) {
//                     if (role != null) {
//                       _role = role;
//                     }
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: validateUser,
//                   child: const Text('Register'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class RoleDropdown extends StatefulWidget {
//   final void Function(String?) onRoleSelected;
//   final String initialRole;

//   RoleDropdown({required this.onRoleSelected, this.initialRole = 'citoyen'});

//   @override
//   _RoleDropdownState createState() => _RoleDropdownState();
// }

// class _RoleDropdownState extends State<RoleDropdown> {
//   String? _selectedRole;

//   @override
//   void initState() {
//     super.initState();
//     _selectedRole = widget.initialRole;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<String>(
//       value: _selectedRole,
//       onChanged: (String? newValue) {
//         setState(() {
//           _selectedRole = newValue;
//         });
//         widget.onRoleSelected(newValue);
//       },
//       items:
//           <String>['citoyen', 'chef', 'admin'].map<DropdownMenuItem<String>>((
//             String value,
//           ) {
//             return DropdownMenuItem<String>(value: value, child: Text(value));
//           }).toList(),
//       decoration: InputDecoration(
//         labelText: 'Rôle',
//         border: OutlineInputBorder(),
//       ),
//       validator: (value) {
//         if (!['citoyen', 'chef', 'admin'].contains(value)) {
//           return 'Sélectionnez un rôle valide';
//         }
//         return null;
//       },
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raqib/Screens/login_screen.dart';
import 'package:raqib/Services/auth_services.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  validateUserScreenState createState() => validateUserScreenState();
}

class validateUserScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _obscureText1 = true;
  String _name = '';
  String _NNI = '';
  String _phone_num = '';
  String _password = '';
  String _confirmPassword = '';

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadInitialData());
  }

  void _loadInitialData() {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      setState(() {
        _name = args['name'] ?? '';
        _phone_num = args['phoneNumber'] ?? '';
      });
    }
  }

  Future<void> validateUser() async {
    if (!_formKey.currentState!.validate()) return;
    print(
      "Données envoyées : {"
      "name: $_name, "
      "NNI: $_NNI, "
      "phone: $_phone_num, "
      "password: $_password"
      "}",
    );

    try {
      final response = await AuthServices.validateUser(
        _name,
        _NNI,
        _phone_num,
        _password,
      );

      print("Full server response: ${response.body}");

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        print("Registration successful! Response Data: $responseData");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        print("Registration failed! Response Data: $responseData");
        String errorMessage = 'Registration failed';

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
        _showErrorDialog(errorMessage);
      }
    } catch (e) {
      print("Error during registration: $e");
      _showErrorDialog('Registration error: ${e.toString()}');
    }
  }

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
                Navigator.of(context).pop();
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
      backgroundColor: Color.fromRGBO(240, 248, 235, 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(),
                  keyboardType: TextInputType.number,
                  initialValue: _name,
                  enabled: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  onChanged: (value) => _name = value,
                ),
                SizedBox(height: 80),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'NNI (10 digits)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.app_registration_rounded),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (value) {
                    if (value == null ||
                        value.length != 10 ||
                        !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return 'NNI must be exactly 10 digits';
                    }
                    return null;
                  },
                  onChanged: (value) => _NNI = value,
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: _obscureText,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.length < 4) {
                      return 'Password must be at least 4 characters';
                    }
                    return null;
                  },
                  onChanged: (value) => _password = value,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Repeat the password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText1 = !_obscureText1;
                        });
                      },
                      child: Icon(
                        _obscureText1 ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: _obscureText1,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm your password';
                    }
                    if (value != _password) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  onChanged: (value) => _confirmPassword = value,
                ),
                const SizedBox(height: 19),
                TextFormField(
                  decoration: const InputDecoration(),
                  keyboardType: TextInputType.number,
                  initialValue: _phone_num,
                  enabled: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  onChanged: (value) => _phone_num = value,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: validateUser,
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}