// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:location/location.dart';
// import 'package:raqib/Services/auth_services.dart';
// import 'package:raqib/Services/complaint_services.dart';

// class DeclarePlainte extends StatefulWidget {
//   @override
//   _ComplaintFormState createState() => _ComplaintFormState();
// }

// class _ComplaintFormState extends State<DeclarePlainte> {
//   // Variables pour la localisation
//   final Location _location = Location();
//   bool _isLoadingLocation = false;
//   LocationData? _locationData;
//   String _locationError = '';
//   String _address = '';

//   // Variables pour le formulaire
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _detailsController = TextEditingController();
//   File? _image;
//   bool _isSubmitting = false;
//   String? _selectedMoughataa;

//   // Liste des moughataas
//   final List<String> _moughataas = [
//     'Arafat',
//     'El Mina',
//     'Riyadh',
//     'Ksar',
//     'Sebkha',
//     'Tevragh Zeïna',
//     'Dar Naim',
//     'Teyareth',
//     'Toujounine'
//   ];

//   // Récupérer la localisation
//   Future<void> _getUserLocation() async {
//     setState(() {
//       _isLoadingLocation = true;
//       _locationError = '';
//     });

//     try {
//       final serviceEnabled = await _location.serviceEnabled();
//       if (!serviceEnabled && !await _location.requestService()) {
//         throw Exception('Service de localisation désactivé');
//       }

//       final permission = await _location.hasPermission();
//       if (permission == PermissionStatus.denied &&
//           await _location.requestPermission() != PermissionStatus.granted) {
//         throw Exception('Permission de localisation refusée');
//       }

//       final locationData = await _location.getLocation();
//       setState(() {
//         _locationData = locationData;
//         _address = 'Lat: ${locationData.latitude?.toStringAsFixed(4)}, '
//                   'Lng: ${locationData.longitude?.toStringAsFixed(4)}';
//       });
//     } catch (e) {
//       setState(() => _locationError = e.toString());
//     } finally {
//       setState(() => _isLoadingLocation = false);
//     }
//   }

//   // Soumettre la plainte
//   Future<void> _submitComplaint() async {
//     if (!_formKey.currentState!.validate()) return;
//     if (_selectedMoughataa == null) {
//       _showSnackBar('Veuillez sélectionner une moughataa');
//       return;
//     }

//     setState(() => _isSubmitting = true);

//     try {
//       final token = await AuthServices.getToken();
//       if (token == null) throw Exception('Utilisateur non authentifié');

//       final response = await ComplaintServices.submitComplaint(
//         details: _detailsController.text,
//         address: _address,
//         moughataa: _selectedMoughataa!,
//         image: _image,
//         token: token,
//       );

//       final responseData = json.decode(response.body);
//       _showSnackBar(responseData['message'] ?? 'Plainte soumise avec succès');

//       if (response.statusCode == 200) {
//         _formKey.currentState!.reset();
//         setState(() {
//           _image = null;
//           _locationData = null;
//           _address = '';
//           _selectedMoughataa = null;
//         });
//       }
//     } catch (e) {
//       _showSnackBar(e.toString());
//     } finally {
//       setState(() => _isSubmitting = false);
//     }
//   }

//   // Sélectionner une image
//   Future<void> _pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() => _image = File(pickedFile.path));
//     }
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         behavior: SnackBarBehavior.floating,
//       )
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(240, 248, 235, 1),
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(100.0),
//         child: ClipPath(
//           clipper: CurvedBottomClipper(),
//           child: Container(
//             color: const Color.fromARGB(255, 45, 205, 9),
//             child: const Center(
//               child: Text(
//                 'الشكاوى',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 28.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // Champ de détails
//               _buildDetailsField(),
//               SizedBox(height: 20),

//               // Dropdown pour la moughataa
//               _buildMoughataaDropdown(),
//               SizedBox(height: 20),

//               // Bouton de localisation
//               _buildLocationButton(),
//               SizedBox(height: 10),

//               // Affichage de la localisation/erreur
//               _buildLocationInfo(),
//               SizedBox(height: 20),

//               // Sélection d'image
//               _buildImagePicker(),
//               SizedBox(height: 30),

//               // Bouton de soumission
//               _buildSubmitButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailsField() {
//     return TextFormField(
//       controller: _detailsController,
//       decoration: InputDecoration(
//         labelText: 'Détails de la plainte',
//         labelStyle: TextStyle(color: Colors.black87),
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide.none,
//         ),
//         contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
//       ),
//       maxLines: 4,
//       validator: (value) => value!.isEmpty ? 'Ce champ est obligatoire' : null,
//     );
//   }

//   Widget _buildMoughataaDropdown() {
//     return DropdownButtonFormField<String>(
//       value: _selectedMoughataa,
//       decoration: InputDecoration(
//         labelText: 'Moughataa',
//         labelStyle: TextStyle(color: Colors.black87),
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide.none,
//         ),
//         contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       ),
//       items: _moughataas.map((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//       onChanged: (newValue) {
//         setState(() {
//           _selectedMoughataa = newValue;
//         });
//       },
//       validator: (value) => value == null ? 'Veuillez sélectionner une moughataa' : null,
//       isExpanded: true,
//       hint: Text('Sélectionnez votre moughataa'),
//     );
//   }

//   Widget _buildLocationButton() {
//     return ElevatedButton(
//       onPressed: _isLoadingLocation ? null : _getUserLocation,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.blue[800],
//         foregroundColor: Colors.white,
//         elevation: 2,
//         minimumSize: Size(double.infinity, 50),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         padding: EdgeInsets.symmetric(vertical: 15),
//       ),
//       child: _isLoadingLocation
//           ? SizedBox(
//               width: 24,
//               height: 24,
//               child: CircularProgressIndicator(
//                 strokeWidth: 3,
//                 color: Colors.white,
//               ),
//             )
//           : Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.location_on, size: 20),
//                 SizedBox(width: 8),
//                 Text(
//                   "Localiser votre position",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }

//   Widget _buildLocationInfo() {
//     if (_isLoadingLocation) return SizedBox();

//     if (_locationError.isNotEmpty) {
//       return Text(
//         _locationError,
//         style: TextStyle(color: Colors.red, fontSize: 14),
//       );
//     }

//     if (_locationData != null) {
//       return Container(
//         padding: EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.blue[50],
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Text(
//           'Position actuelle: $_address',
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.blue[900],
//           ),
//         ),
//       );
//     }

//     return SizedBox();
//   }

//   Widget _buildImagePicker() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Ajouter une photo (optionnel)',
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         SizedBox(height: 8),
//         InkWell(
//           onTap: _pickImage,
//           borderRadius: BorderRadius.circular(10),
//           child: Container(
//             height: 150,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: Colors.grey[400]!),
//             ),
//             child: _image == null
//                 ? Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.camera_alt, size: 40, color: Colors.grey[600]),
//                       SizedBox(height: 8),
//                       Text(
//                         'Cliquez pour ajouter une photo',
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                     ],
//                   )
//                 : ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.file(_image!, fit: BoxFit.cover),
//                   ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSubmitButton() {
//     return ElevatedButton(
//       onPressed: _isSubmitting ? null : _submitComplaint,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.green[700],
//         foregroundColor: Colors.white,
//         elevation: 2,
//         minimumSize: Size(double.infinity, 50),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         padding: EdgeInsets.symmetric(vertical: 15),
//       ),
//       child: _isSubmitting
//           ? SizedBox(
//               width: 24,
//               height: 24,
//               child: CircularProgressIndicator(
//                 strokeWidth: 3,
//                 color: Colors.white,
//               ),
//             )
//           : Text(
//               'SOUMETTRE LA PLAINTE',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 1,
//               ),
//             ),
//     );
//   }
// }

// class CurvedBottomClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.lineTo(0, size.height - 40);
//     path.quadraticBezierTo(
//       size.width / 2,
//       size.height,
//       size.width,
//       size.height - 40,
//     );
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:raqib/Screens/plaintes/chef_local/home_screen_chef.dart';
import 'package:raqib/Screens/plaintes/chef_local/notification_plainte.dart';
import 'package:raqib/Services/auth_services.dart';
import 'package:raqib/Services/complaint_services.dart';
import 'package:raqib/provider/chef_notification.dart';
// import 'package:raqib/providers/chef_notification_provider.dart';

class DeclarePlainte extends StatefulWidget {
  @override
  _ComplaintFormState createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<DeclarePlainte> {
  // Variables pour la localisation
  final Location _location = Location();
  bool _isLoadingLocation = false;
  LocationData? _locationData;
  String _locationError = '';
  String _address = '';

  // Variables pour le formulaire
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _detailsController = TextEditingController();
  File? _image;
  bool _isSubmitting = false;
  String? _selectedMoughataa;

  // Liste des moughataas
  final List<String> _moughataas = [
    'Arafat',
    'El Mina',
    'Riyadh',
    'Ksar',
    'Sebkha',
    'Tevragh Zeïna',
    'Dar Naim',
    'Teyareth',
    'Toujounine',
  ];

  // Récupérer la localisation
  Future<void> _getUserLocation() async {
    setState(() {
      _isLoadingLocation = true;
      _locationError = '';
    });

    try {
      final serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled && !await _location.requestService()) {
        throw Exception('Service de localisation désactivé');
      }

      final permission = await _location.hasPermission();
      if (permission == PermissionStatus.denied &&
          await _location.requestPermission() != PermissionStatus.granted) {
        throw Exception('Permission de localisation refusée');
      }

      final locationData = await _location.getLocation();
      setState(() {
        _locationData = locationData;
        _address =
            'Lat: ${locationData.latitude?.toStringAsFixed(4)}, '
            'Lng: ${locationData.longitude?.toStringAsFixed(4)}';
      });
    } catch (e) {
      setState(() => _locationError = e.toString());
    } finally {
      setState(() => _isLoadingLocation = false);
    }
  }

  // Soumettre la plainte
  // Future<void> _submitComplaint() async {
  //   if (!_formKey.currentState!.validate()) return;
  //   if (_selectedMoughataa == null) {
  //     _showSnackBar('Veuillez sélectionner une moughataa');
  //     return;
  //   }

  //   setState(() => _isSubmitting = true);

  //   try {
  //     final token = await AuthServices.getToken();
  //     if (token == null) throw Exception('Utilisateur non authentifié');

  //     // Envoyer la plainte au serveur
  //     final response = await ComplaintServices.submitComplaint(
  //       details: _detailsController.text,
  //       address: _address,
  //       moughataa: _selectedMoughataa!,
  //       image: _image,
  //       token: token,
  //     );

  //     final responseData = json.decode(response.body);
  //     _showSnackBar(responseData['message'] ?? 'Plainte soumise avec succès');
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => HomeScreenChef()),
  //     );

  //     // Notifier le provider de la nouvelle plainte
  //     if (response.statusCode == 200) {
  //       // Notifier le provider AVANT la navigation
  //       context.read<ChefNotification>().plainteNotification(
  //         details: _detailsController.text,
  //         moughataa: _selectedMoughataa!,
  //         address: _address,
  //         image: _image,
  //       );

  //       // Naviguer sans remplacer pour pouvoir revenir en arrière
  //       // Navigator.push(
  //       //   context,
  //       //   MaterialPageRoute(builder: (context) => HomeScreenChef()),
  //       // );

  //       // Réinitialiser le formulaire
  //       _formKey.currentState!.reset();
  //       setState(() {
  //         _image = null;
  //         _locationData = null;
  //         _address = '';
  //         _selectedMoughataa = null;
  //       });
  //     }
  //   } catch (e) {
  //     _showSnackBar(e.toString());
  //   } finally {
  //     setState(() => _isSubmitting = false);
  //   }
  // }

  // soumettre 2

 Future<void> _submitComplaint() async {
  if (!_formKey.currentState!.validate()) return;
  if (_selectedMoughataa == null) {
    _showSnackBar('Veuillez sélectionner une moughataa');
    return;
  }

  setState(() => _isSubmitting = true);

  try {
    final token = await AuthServices.getToken();
    if (token == null) throw Exception('Utilisateur non authentifié');

    final response = await ComplaintServices.submitComplaint(
      details: _detailsController.text,
      address: _address,
      moughataa: _selectedMoughataa!,
      image: _image,
      token: token,
    );

    final responseData = json.decode(response.body);
    
    // Modification clé ici : Vérifiez le statut avant de traiter la réponse
    if (response.statusCode >= 200 && response.statusCode < 300) {
      String? imageBase64;
      if (_image != null) {
        final bytes = await _image!.readAsBytes();
        imageBase64 = base64Encode(bytes);
      }

      // Mise à jour du Provider
      if (mounted) {
        context.read<ChefNotification>().plainteNotification(
          details: _detailsController.text,
          moughataa: _selectedMoughataa!,
          address: _address,
          image: imageBase64,
        );
      }

      // Réinitialisation et navigation
      _resetForm();
      
      // Navigation garantie avec cette approche
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => HomeScreenChef()),
            (route) => false,
          );
        }
      });

      // Message de succès
      _showSnackBar(responseData['message'] ?? 'Plainte enregistrée avec succès');
    } else {
      throw Exception(responseData['message'] ?? 'Erreur lors de l\'enregistrement');
    }
  } catch (e) {
    // Gestion améliorée des erreurs
    final errorMsg = e.toString().replaceFirst('Exception: ', '');
    _showSnackBar('Erreur: $errorMsg');
    debugPrint('Erreur soumission plainte: $e');
  } finally {
    if (mounted) {
      setState(() => _isSubmitting = false);
    }
  }
}

void _resetForm() {
  if (mounted) {
    _formKey.currentState?.reset();
    setState(() {
      _image = null;
      _locationData = null;
      _address = '';
      _selectedMoughataa = null;
    });
  }
}

  // Sélectionner une image
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 248, 235, 1),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Champ de détails
              _buildDetailsField(),
              SizedBox(height: 20),

              // Dropdown pour la moughataa
              _buildMoughataaDropdown(),
              SizedBox(height: 20),

              // Bouton de localisation
              _buildLocationButton(),
              SizedBox(height: 10),

              // Affichage de la localisation/erreur
              _buildLocationInfo(),
              SizedBox(height: 20),

              // Sélection d'image
              _buildImagePicker(),
              SizedBox(height: 30),

              // Bouton de soumission
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsField() {
    return TextFormField(
      controller: _detailsController,
      decoration: InputDecoration(
        labelText: 'Détails de la plainte',
        labelStyle: TextStyle(color: Colors.black87),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      ),
      maxLines: 4,
      validator: (value) => value!.isEmpty ? 'Ce champ est obligatoire' : null,
    );
  }

  Widget _buildMoughataaDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedMoughataa,
      decoration: InputDecoration(
        labelText: 'Moughataa',
        labelStyle: TextStyle(color: Colors.black87),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      items:
          _moughataas.map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedMoughataa = newValue;
        });
      },
      validator:
          (value) =>
              value == null ? 'Veuillez sélectionner une moughataa' : null,
      isExpanded: true,
      hint: Text('Sélectionnez votre moughataa'),
    );
  }

  Widget _buildLocationButton() {
    return ElevatedButton(
      onPressed: _isLoadingLocation ? null : _getUserLocation,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        elevation: 2,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(vertical: 15),
      ),
      child:
          _isLoadingLocation
              ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Localiser votre position",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
    );
  }

  Widget _buildLocationInfo() {
    if (_isLoadingLocation) return SizedBox();

    if (_locationError.isNotEmpty) {
      return Text(
        _locationError,
        style: TextStyle(color: Colors.red, fontSize: 14),
      );
    }

    if (_locationData != null) {
      return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Position actuelle: $_address',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.blue[900],
          ),
        ),
      );
    }

    return SizedBox();
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ajouter une photo (optionnel)',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        InkWell(
          onTap: _pickImage,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey[400]!),
            ),
            child:
                _image == null
                    ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Colors.grey[600],
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Cliquez pour ajouter une photo',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    )
                    : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(_image!, fit: BoxFit.cover),
                    ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _isSubmitting ? null : _submitComplaint,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        elevation: 2,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(vertical: 15),
      ),
      child:
          _isSubmitting
              ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              )
              : Text(
                'SOUMETTRE LA PLAINTE',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
    );
  }
}

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
