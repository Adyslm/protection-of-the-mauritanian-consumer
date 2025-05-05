// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:raqib/Services/globals.dart';

// class ComplaintServices {
  


//   static Future<http.Response> submitComplaint({
//   required String details,
//   required String address,
//   required File? image,
//   required String token,
// }) async {
//   try {
//     // 1. Vérification du token
//     if (token.isEmpty) throw Exception('Token invalide');

//     // 2. Création de la requête multipart
//     final request = http.MultipartRequest('POST', Uri.parse('${baseURL}plaintes'))
//       ..headers['Authorization'] = 'Bearer $token'
//       ..fields['details'] = details
//       ..fields['adresse'] = address;

//     // 3. Ajout de l'image si elle existe
//     if (image != null) {
//       request.files.add(
//         await http.MultipartFile.fromPath('image', image.path),
//       );
//     }

//     // 4. Envoi et traitement de la réponse
//     final streamedResponse = await request.send();
//     final response = await http.Response.fromStream(streamedResponse);

//     if (response.statusCode == 201) {
//       return response;
//     } else {
//       final errorData = json.decode(response.body);
//       throw Exception(errorData['message'] ?? 'Erreur lors de la soumission');
//     }
//   } catch (e) {
//     throw Exception('Échec de la requête: ${e.toString()}');
//   }
// }

  


//   static Future<List<dynamic>> getComplaints(String token) async {
//   try {
//     // 1. Vérification du token
//     if (token.isEmpty) throw Exception('Token invalide');

//     // 2. Requête GET
//     final response = await http.get(
//       Uri.parse('${baseURL}plaintes'),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//     );

//     // 3. Traitement de la réponse
//     if (response.statusCode == 200) {
//       return json.decode(response.body) as List<dynamic>;
//     } else {
//       throw Exception(
//         'Erreur ${response.statusCode}: ${response.body.isNotEmpty ? json.decode(response.body)['message'] : 'Pas de détail'}',
//       );
//     }
//   } catch (e) {
//     throw Exception('Échec de la récupération: ${e.toString()}');
//   }
// }

// }







import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:raqib/Services/globals.dart';

class ComplaintServices {
  static Future<http.Response> submitComplaint({
    required String details,
    required String address,
    required String moughataa,
    required File? image,
    required String token,
  }) async {
    try {
      if (token.isEmpty) throw Exception('Token invalide');

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${baseURL}plaintes'),
      )
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['details'] = details
        ..fields['adresse'] = address
        ..fields['moughataa'] = moughataa;

      if (image != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', image.path),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        return response;
      } else {
        final errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Erreur lors de la soumission');
      }
    } catch (e) {
      throw Exception('Échec de la requête: ${e.toString()}');
    }
  }

  static Future<List<dynamic>> getComplaints(String token) async {
    try {
      if (token.isEmpty) throw Exception('Token invalide');

      final response = await http.get(
        Uri.parse('${baseURL}plaintes'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body) as List<dynamic>;
      } else {
        throw Exception(
          'Erreur ${response.statusCode}: ${response.body.isNotEmpty ? json.decode(response.body)['message'] : 'Pas de détail'}',
        );
      }
    } catch (e) {
      throw Exception('Échec de la récupération: ${e.toString()}');
    }
  }
}