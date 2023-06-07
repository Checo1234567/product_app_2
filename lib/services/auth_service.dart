import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyBGSuJbI5NEsqNjCKi0i_t67JB0d2IJMKc';
  final storage = const FlutterSecureStorage();

// Si se retornamos algo entonces significa que algo salio mal.
  Future<String?> signUp(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});

    final res = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedRes = json.decode(res.body);

    if (decodedRes.containsKey('idToken')) {
      //Guardar el token en Secure Storage
      storage.write(key: 'idToken', value: decodedRes['idToken']);
      return null;
    } else {
      return decodedRes['error']['message'];
    }
  }

  Future<String?> logIn(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});

    final res = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedRes = json.decode(res.body);

    if (decodedRes.containsKey('idToken')) {
      // Guardar el token en Secure Storage
      storage.write(key: 'idToken', value: decodedRes['idToken']);
      return null;
    } else {
      return decodedRes['error']['message'];
    }
  }

  Future logOut() async {
    await storage.delete(key: 'idToken');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'idToken') ?? '';
  }
}
