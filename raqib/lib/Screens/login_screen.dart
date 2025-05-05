// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:raqib/Screens/auth.dart';
// import 'package:raqib/Screens/home_screen.dart';
// import 'package:raqib/Screens/plaintes/declare_plainte.dart';
// import 'package:raqib/Screens/register_screen.dart';
// import 'package:raqib/Services/auth_services.dart';
// import 'package:raqib/Services/chef/admin_screen.dart';
// import 'package:raqib/Services/chef/chef_screen.dart';
// import 'package:raqib/Services/chef/citoyen_screen.dart';
// import 'package:raqib/Services/globals.dart';

// // Import the new screens

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool _obscureText = true;
//   final _formKey = GlobalKey<FormState>();
//   String _password = '';
//   String _role = 'citoyen';
//   int _phoneNum = 0; // Changed type to int and renamed to _phoneNum

//   Future<void> _login() async {
//     if (!_formKey.currentState!.validate()) return;

//     try {
//       final response = await AuthServices.login(
//         _phoneNum,
//         _password,
//         _role,
//       ); // Pass _phoneNum
//       final responseData = json.decode(response.body);

//       if (response.statusCode == 200) {
//         // Get the user's role from the response.  Adjust 'role' as needed.
//         final userRole = responseData['user']['role']; //  adjust the key

//         // Navigate based on the role.
//         switch (userRole) {
//           case 'citoyen':
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => HomeScreen()),
//             );
//             break;
//           case 'chef':
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => ChefScreen()),
//             );
//             break;
//           case 'admin':
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => AdminScreen()),
//             );
//             break;
//           default:
//             // Handle the case where the role is unexpected.
//             errorSnackBar(context, 'Invalid role: $userRole');
//             break;
//         }
//       } else {
//         final errorMessage =
//             responseData['message'] ??
//             'Incorrect phone number, password, or role'; //update error message
//         errorSnackBar(context, errorMessage.toString());
//       }
//     } catch (e) {
//       errorSnackBar(context, 'Login error: ${e.toString()}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Color.fromRGBO(240, 248, 235, 1),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: 100),
//               Icon(Icons.lock, size: 150),
//               SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       // PHONE NUMBER FIELD
//                       TextFormField(
//                         decoration: InputDecoration(
//                           labelText:
//                               'Numero de Telephone', // Changed label text
//                           prefixIcon: Icon(Icons.call), // Kept the phone icon
//                           border: OutlineInputBorder(
//                             // Added OutlineInputBorder
//                             borderRadius: BorderRadius.circular(
//                               25.0,
//                             ), // Rounded corners
//                           ),
//                           filled: true, // Added filled property
//                           fillColor: Colors.white, // Set fill color to white
//                           contentPadding: EdgeInsets.symmetric(
//                             vertical: 10.0,
//                             horizontal: 16.0,
//                           ), // Added padding
//                         ),
//                         keyboardType:
//                             TextInputType.phone, // Ensure correct keyboard type
//                         inputFormatters: [
//                           FilteringTextInputFormatter.digitsOnly,
//                         ],
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Numero de Telephone est requis';
//                           }
//                           if (value.length < 8) {
//                             return 'Numero de Telephone doit contenir au moins 8 chiffres';
//                           }
//                           return null;
//                         },
//                         onChanged: (value) {
//                           // Parse the input as an integer
//                           _phoneNum = int.tryParse(value) ?? 0;
//                         },
//                       ),
//                       SizedBox(height: 10),
//                       // PASSWORD FIELD
//                       TextFormField(
//                         keyboardType: TextInputType.phone,
//                         decoration: InputDecoration(
//                           labelText:
//                               'Mot de passe', 
//                           prefixIcon: Icon(Icons.lock),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(
//                               25.0,
//                             ), // Added for rounded corners
//                           ),
//                           filled: true,
//                           fillColor: Colors.white,
//                           contentPadding: EdgeInsets.symmetric(
//                             vertical: 10.0,
//                             horizontal: 16.0,
//                           ),
//                           suffixIcon: GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 _obscureText = !_obscureText;
//                               });
//                             },
//                             child: Icon(
//                               _obscureText
//                                   ? Icons.visibility_off
//                                   : Icons.visibility,
//                             ),
//                           ),
//                         ),
//                         obscureText: _obscureText,
//                         validator: (value) {
//                           if (value == null || value.length < 4) {
//                             return 'Mot de passe doit contenir au moins 4 caractères';
//                           }
//                           return null;
//                         },
//                         onChanged: (value) => _password = value,
//                       ),

//                       const SizedBox(height: 20),
//                       RoleDropdown(
//                         initialRole: _role,
//                         onRoleSelected: (String? role) {
//                           if (role != null) {
//                             _role = role;
//                           }
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           ElevatedButton(
//                             onPressed: _login,
//                             child: const Text(
//                               'Entrer',
//                               style: TextStyle(
//                                 fontSize: 18.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             style: ElevatedButton.styleFrom(
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: 12.0,
//                                 horizontal: 40.0,
//                               ),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(5.0),
//                               ),
//                               backgroundColor: Colors.green,
//                               foregroundColor: Colors.white,
                              
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10,),
//                       Row(
//                         children: [
//                           Text("You don't have an account?",
//                           style: TextStyle( 
//                             color: Colors.black, 
//                             fontWeight: FontWeight.bold
//                           ),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => Auth_Screen(),
//                                 ),
//                               );
//                             },
//                             child: Text("Creat an account!",
//                             style: TextStyle(
//                             color: Color.fromRGBO(60, 179, 113, 1),
//                             fontWeight: FontWeight.bold
//                           ),),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
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
//         if (value == null || !['citoyen', 'chef', 'admin'].contains(value)) {
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
import 'package:raqib/Screens/auth.dart';
import 'package:raqib/Screens/home_screen.dart';
// import 'package:raqib/Screens/plaintes/declare_plainte.dart';
// import 'package:raqib/Screens/register_screen.dart';
import 'package:raqib/Services/auth_services.dart';
import 'package:raqib/Services/globals.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  String _password = '';
  int _phoneNum = 0;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final response = await AuthServices.login(
        _phoneNum,
        _password,
      );
      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        final errorMessage = responseData['message'] ?? 'Incorrect phone number or password';
        errorSnackBar(context, errorMessage.toString());
      }
    } catch (e) {
      errorSnackBar(context, 'Login error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(240, 248, 235, 1),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100),
              Icon(Icons.lock, size: 150),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // PHONE NUMBER FIELD
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Numero de Telephone',
                          prefixIcon: Icon(Icons.call),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 16.0,
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Numero de Telephone est requis';
                          }
                          if (value.length < 8) {
                            return 'Numero de Telephone doit contenir au moins 8 chiffres';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _phoneNum = int.tryParse(value) ?? 0;
                        },
                      ),
                      SizedBox(height: 10),
                      // PASSWORD FIELD
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Mot de passe', 
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 16.0,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        obscureText: _obscureText,
                        validator: (value) {
                          if (value == null || value.length < 4) {
                            return 'Mot de passe doit contenir au moins 4 caractères';
                          }
                          return null;
                        },
                        onChanged: (value) => _password = value,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 40.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text(
                              'Entrer',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text("You don't have an account?",
                            style: TextStyle( 
                              color: Colors.black, 
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Auth_Screen(),
                                ),
                              );
                            },
                            child: Text("Creat an account!",
                              style: TextStyle(
                                color: Color.fromRGBO(60, 179, 113, 1),
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:raqib/Screens/auth.dart';
// import 'package:raqib/Screens/home_screen.dart';
// import 'package:raqib/Services/auth_services.dart';
// import 'package:raqib/Services/globals.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool _obscureText = true;
//   bool _isLoading = false; // Ajout de l'état de chargement
//   final _formKey = GlobalKey<FormState>();
//   String _password = '';
//   int _phoneNum = 0;

//   Future<void> _login() async {
//     if (!_formKey.currentState!.validate() || _isLoading) return;

//     setState(() => _isLoading = true); // Activation du loading

//     try {
//       final response = await AuthServices.login(
//         _phoneNum,
//         _password,
//       ).timeout(const Duration(seconds: 30)); // Timeout après 30s

//       final responseData = json.decode(response.body);

//       if (response.statusCode == 200) {
//         // Navigation avec indicateur de chargement
//         await Navigator.pushReplacement(
//           context,
//           PageRouteBuilder(
//             pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
//             transitionsBuilder: (context, animation, secondaryAnimation, child) {
//               return FadeTransition(
//                 opacity: animation,
//                 child: child,
//               );
//             },
//             transitionDuration: const Duration(milliseconds: 300),
//           ),
//         );
//       } else {
//         final errorMessage = responseData['message'] ?? 'Numéro ou mot de passe incorrect';
//         errorSnackBar(context, errorMessage);
//       }
//     } on TimeoutException {
//       errorSnackBar(context, 'La connexion a pris trop de temps');
//     } catch (e) {
//       errorSnackBar(context, 'Erreur: ${e.toString()}');
//     } finally {
//       if (mounted) {
//         setState(() => _isLoading = false); // Désactivation du loading
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color.fromRGBO(240, 248, 235, 1),
//         body: Stack( // Utilisation d'un Stack pour le loading overlay
//           children: [
//             SingleChildScrollView(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 100),
//                   const Icon(Icons.lock, size: 150),
//                   const SizedBox(height: 20),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         children: [
//                           TextFormField(
//                             decoration: InputDecoration(
//                               labelText: 'Numero de Telephone',
//                               prefixIcon: const Icon(Icons.call),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25.0),
//                               ),
//                               filled: true,
//                               fillColor: Colors.white,
//                               contentPadding: const EdgeInsets.symmetric(
//                                 vertical: 10.0,
//                                 horizontal: 16.0,
//                               ),
//                             ),
//                             keyboardType: TextInputType.phone,
//                             inputFormatters: [
//                               FilteringTextInputFormatter.digitsOnly,
//                             ],
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Numero de Telephone est requis';
//                               }
//                               if (value.length < 8) {
//                                 return 'Numero de Telephone doit contenir au moins 8 chiffres';
//                               }
//                               return null;
//                             },
//                             onChanged: (value) {
//                               _phoneNum = int.tryParse(value) ?? 0;
//                             },
//                           ),
//                           const SizedBox(height: 10),
//                           TextFormField(
//                             keyboardType: TextInputType.phone,
//                             decoration: InputDecoration(
//                               labelText: 'Mot de passe',
//                               prefixIcon: const Icon(Icons.lock),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25.0),
//                               ),
//                               filled: true,
//                               fillColor: Colors.white,
//                               contentPadding: const EdgeInsets.symmetric(
//                                 vertical: 10.0,
//                                 horizontal: 16.0,
//                               ),
//                               suffixIcon: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     _obscureText = !_obscureText;
//                                   });
//                                 },
//                                 child: Icon(
//                                   _obscureText
//                                       ? Icons.visibility_off
//                                       : Icons.visibility,
//                                 ),
//                               ),
//                             ),
//                             obscureText: _obscureText,
//                             validator: (value) {
//                               if (value == null || value.length < 4) {
//                                 return 'Mot de passe doit contenir au moins 4 caractères';
//                               }
//                               return null;
//                             },
//                             onChanged: (value) => _password = value,
//                           ),
//                           const SizedBox(height: 20),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               ElevatedButton(
//                                 onPressed: _isLoading ? null : _login,
//                                 style: ElevatedButton.styleFrom(
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 12.0,
//                                     horizontal: 40.0,
//                                   ),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(5.0),
//                                   ),
//                                   backgroundColor: Colors.green,
//                                   foregroundColor: Colors.white,
//                                 ),
//                                 child: _isLoading
//                                     ? const SizedBox(
//                                         width: 20,
//                                         height: 20,
//                                         child: CircularProgressIndicator(
//                                           strokeWidth: 2,
//                                           color: Colors.white,
//                                         ),
//                                       )
//                                     : const Text(
//                                         'Entrer',
//                                         style: TextStyle(
//                                           fontSize: 18.0,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 10),
//                           Row(
//                             children: [
//                               Text("You don't have an account?",
//                                 style: TextStyle( 
//                                   color: Colors.black, 
//                                   fontWeight: FontWeight.bold
//                                 ),
//                               ),
//                               TextButton(
//                                 onPressed: _isLoading
//                                     ? null
//                                     : () {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) => const Auth_Screen(),
//                                           ),
//                                         );
//                                       },
//                                 child: Text("Creat an account!",
//                                   style: TextStyle(
//                                     color: const Color.fromRGBO(60, 179, 113, 1),
//                                     fontWeight: FontWeight.bold
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (_isLoading)
//               const ModalBarrier(
//                 color: Colors.black54,
//                 dismissible: false,
//               ),
//             if (_isLoading)
//               Center(
//                 child: Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: const Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       CircularProgressIndicator(),
//                       SizedBox(height: 16),
//                       Text('Connexion en cours...'),
//                     ],
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }