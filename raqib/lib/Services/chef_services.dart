import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:http/http.dart' as _storage;
import 'package:raqib/Services/globals.dart' as constants;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChefServices {
  // Utilisation de FlutterSecureStorage pour un stockage plus sécurisé
  static const _storage = FlutterSecureStorage();
  static const String _tokenKey = 'chef_token';


  // Méthode pour effectuer les requêtes HTTP avec gestion d'erreur centralisée
  static Future<Map<String, dynamic>> _makeRequest(
    String url,
    String method,
    Map<String, dynamic> body,
  ) async {
    try {
      final uri = Uri.parse('${constants.baseURL}$url');
      final headers = {'Content-Type': 'application/json'};
      final encodedBody = json.encode(body);

      http.Response response;
      switch (method.toLowerCase()) {
        case 'post':
          response = await http.post(uri, headers: headers, body: encodedBody);
          break;
        default:
          throw Exception('Méthode HTTP non supportée');
      }

      final data = json.decode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {'success': true, 'data': data};
      } else {
        throw _handleError(data, response.statusCode);
      }
    } on http.ClientException catch (e) {
      throw Exception('Erreur de connexion: ${e.message}');
    } on FormatException {
      throw Exception('Réponse serveur invalide');
    } catch (e) {
      throw Exception('Erreur inattendue: ${e.toString()}');
    }
  }

  // Gestion centralisée des erreurs
  static Exception _handleError(Map<String, dynamic> data, int statusCode) {
    if (data.containsKey('errors')) {
      final errors = (data['errors'] as Map<String, dynamic>).entries
        .map((entry) => '${entry.key}: ${(entry.value as List).join(', ')}')
        .join('\n');
      return Exception(errors);
    } else if (data.containsKey('message')) {
      return Exception(data['message'] as String);
    } else {
      return Exception('Erreur inconnue (code $statusCode)');
    }
  }

  static Future<Map<String, dynamic>> register({
    required String name,
    required String nni,
    required String phoneNum,
    required String moughataa,
    required String password,
  }) async {
    final result = await _makeRequest(
      'chefs/register',
      'POST',
      {
        'name': name,
        'NNI': nni,
        'phone_num': phoneNum,
        'moughataa': moughataa,
        'mdp': password,
      },
    );

    if (result['success'] && result['data']['token'] != null) {
      await _storage.write(key: _tokenKey, value: result['data']['token'] as String);
    }
    
    return result;
  }

  static Future<Map<String, dynamic>> login({
    required String phoneNum,
    required String password,
  }) async {
    final result = await _makeRequest(
      'chefs/login',
      'POST',
      {
        'phone_num': phoneNum,
        'mdp': password,
      },
    );

    if (result['success'] && result['data']['token'] != null) {
      await _storage.write(key: _tokenKey, value: result['data']['token'] as String);
    }
    
    return result;
  }

  static Future<String?> getToken() async {
    try {
      return await _storage.read(key: _tokenKey);
    } catch (e) {
      throw Exception('Failed to retrieve token: ${e.toString()}');
    }
  }

  static Future<void> logout() async {
    try {
      await _storage.delete(key: _tokenKey);
    } catch (e) {
      throw Exception('Failed to logout: ${e.toString()}');
    }
  }

  static Future<bool> isLoggedIn() async {
    try {
      final token = await getToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

/////////////////

static Future<Map<String, dynamic>> getAuthenticatedChef() async {
  try {
    final token = await getToken();
    if (token == null || token.isEmpty) {
      throw Exception('Token non disponible');
    }

    // Corrigez cette ligne pour utiliser le bon endpoint
    final uri = Uri.parse('${constants.baseURL}chefs/me');
    
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(uri, headers: headers);
    
    debugPrint('Status Code: ${response.statusCode}');
    debugPrint('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final decodedBody = json.decode(response.body);
      return {
        'success': true,
        'data': decodedBody['data'] // Accédez à la propriété 'data' du JSON
      };
    } else {
      throw Exception('Erreur serveur: ${response.statusCode}');
    }
  } on FormatException catch (e) {
    throw Exception('Format de réponse invalide: ${e.message}');
  } catch (e) {
    throw Exception('Erreur: ${e.toString()}');
  }
}

// Ensure this parsing method exists
String _parseErrors(Map<String, dynamic> errors) {
  return errors.entries
      .map((entry) => '${entry.key}: ${(entry.value as List).join(', ')}')
      .join('\n');
}
  

}




