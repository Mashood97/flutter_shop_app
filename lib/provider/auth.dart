import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttershopapp/models/http_exception.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return _token;
  }

  Future<void> autheticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCif9dQdLelHNiacY_MpBHmJBcDZxTnHc4';

    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final extractedData = json.decode(response.body);
      if (extractedData['error'] != null) {
        throw HttpException(extractedData['error']['message']);
      }
      _token = extractedData['idToken'];
      _userId = extractedData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            (extractedData['expiresIn']),
          ),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String email, String password) async {
    return autheticate(email, password, 'signUp');
//    const url =
//        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCif9dQdLelHNiacY_MpBHmJBcDZxTnHc4';
//
//    try {
//      final response = await http.post(url,
//          body: json.encode({
//            'email': email,
//            'password': password,
//            'returnSecureToken': true,
//          }));
//      final extractedData = json.decode(response.body);
//      if (extractedData['error'] != null) {
//        throw HttpException(extractedData['error']['message']);
//      }
//      _token = extractedData['idToken'];
//      _userId = extractedData['localId'];
//      _expiryDate = DateTime.now().add(
//        Duration(
//          seconds: int.parse(
//            (extractedData['expiresIn']),
//          ),
//        ),
//      );
//      notifyListeners();
//    } catch (error) {
//      throw error;
//    }
//
//    print(json.decode(response.body));
  }

  Future<void> signIn(String email, String password) async {
    return autheticate(email, password, 'signInWithPassword');

//    const url =
//        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCif9dQdLelHNiacY_MpBHmJBcDZxTnHc4';
//
//    try {
//      final response = await http.post(url,
//          body: json.encode({
//            'email': email,
//            'password': password,
//            'returnSecureToken': true,
//          }));
//      final extractedData = json.decode(response.body);
//      if (extractedData['error'] != null) {
//        throw HttpException(extractedData['error']['message']);
//      }
//    } catch (error) {
//      throw error;
//    }

//    print(json.decode(response.body));
  }
}
