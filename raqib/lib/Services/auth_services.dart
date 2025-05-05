// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'globals.dart' as constants;

// class AuthServices {
//   // ==== Méthode de vérification (étape 1 d'inscription) ====
//   static Future<http.Response> verify(String name, String phoneNum) async {
//     try {
//       final Map<String, dynamic> data = {"name": name, "phone_num": phoneNum};
//       final response = await http.post(
//         Uri.parse('${constants.baseURL}auth/verify'),
//         headers: constants.headers,
//         body: json.encode(data),
//       );
//       if (response.statusCode != 200) {
//         throw _handleError(response);
//       }
//       return response;
//     } catch (e) {
//       throw Exception('Erreur de vérification: ${e.toString()}');
//     }
//   }

//   // ==== Méthode de validation (étape 2 d'inscription) ====
//   static Future<http.Response> validateUser(
//       String name, String nni, String phoneNum, String password, String role) async {
//     try {
//       final Map<String, dynamic> data = {
//         "name": name, "NNI": nni, "phone_num": phoneNum, "mdp": password, "role": role
//       };
//       final response = await http.post(
//       Uri.parse('${constants.baseURL}auth/validateUser'), // URL obligatoire
//       headers: constants.headers,                         // Headers optionnels
//       body: json.encode(data),                           // Body optionnel
//     );
//       if (response.statusCode != 200) throw _handleError(response);
//       return response;
//     } catch (e) {
//       throw Exception('Erreur de validation: ${e.toString()}');
//     }
//   }

//   // ==== Méthode de connexion ====
//   static Future<http.Response> login(int phoneNum, String password, String role) async {
//     try {
//       final response = await http.post(
//         Uri.parse('${constants.baseURL}auth/login'),
//         headers: constants.headers,
//         body: json.encode({
//           "phone_num": phoneNum.toString(),
//           "mdp": password,
//           "role": role,
//         }),
//       );
//       if (response.statusCode == 200) {
//         await _storeToken(json.decode(response.body)['token']);
//         return response;
//       } else {
//         throw _handleError(response);
//       }
//     } catch (e) {
//       throw Exception('Erreur de connexion: ${e.toString()}');
//     }
//   }

//   // ==== Gestion des tokens ====
//   static Future<String?> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('auth_token');
//   }

//   static Future<void> _storeToken(String token) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('auth_token', token);
//   }

//   static Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('auth_token');
//   }

//   // ==== Utilitaires privés ====
//   static Exception _handleError(http.Response response) {
//     final error = json.decode(response.body);
//     return Exception(error['message'] ?? 'Erreur inconnue');
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart' as constants;

class AuthServices {
  // ==== Méthode de vérification (étape 1 d'inscription) ====
  static Future<http.Response> verify(String name, String phoneNum) async {
    try {
      final Map<String, dynamic> data = {"name": name, "phone_num": phoneNum};
      final response = await http.post(
        Uri.parse('${constants.baseURL}auth/verify'),
        headers: constants.headers,
        body: json.encode(data),
      );
      if (response.statusCode != 200) {
        throw _handleError(response);
      }
      return response;
    } catch (e) {
      throw Exception('Erreur de vérification: ${e.toString()}');
    }
  }

  // ==== Méthode de validation (étape 2 d'inscription) ====
  static Future<http.Response> validateUser(
      String name, String nni, String phoneNum, String password) async {
    try {
      final Map<String, dynamic> data = {
        "name": name, 
        "NNI": nni, 
        "phone_num": phoneNum, 
        "mdp": password
      };
      final response = await http.post(
        Uri.parse('${constants.baseURL}auth/validateUser'),
        headers: constants.headers,
        body: json.encode(data),
      );
      if (response.statusCode != 200) throw _handleError(response);
      return response;
    } catch (e) {
      throw Exception('Erreur de validation: ${e.toString()}');
    }
  }

  // ==== Méthode de connexion ====
  static Future<http.Response> login(int phoneNum, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${constants.baseURL}auth/login'),
        headers: constants.headers,
        body: json.encode({
          "phone_num": phoneNum.toString(),
          "mdp": password,
        }),
      );
      if (response.statusCode == 200) {
        await _storeToken(json.decode(response.body)['token']);
        return response;
      } else {
        throw _handleError(response);
      }
    } catch (e) {
      throw Exception('Erreur de connexion: ${e.toString()}');
    }
  }

  // ==== Gestion des tokens ====
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<void> _storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  // ==== Utilitaires privés ====
  static Exception _handleError(http.Response response) {
    final error = json.decode(response.body);
    return Exception(error['message'] ?? 'Erreur inconnue');
  }
}