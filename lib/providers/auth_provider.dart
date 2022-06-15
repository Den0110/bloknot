import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authProvider = Provider((ref) => Authenticator());

class Authenticator {
  SharedPreferences? _prefs;

  int attempts = 0;

  FutureOr<SharedPreferences> _getPrefs() async {
    if (_prefs != null) return _prefs!;
    return await SharedPreferences.getInstance();
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (attempts.isOdd) {
      return Future.delayed(const Duration(seconds: 2));
    }
    attempts++;
    return Future.delayed(const Duration(seconds: 1),
        throw Exception("Incorrect email or password"));
  }

  Future<void> signOut() {
    return Future.delayed(const Duration(seconds: 1));
  }

  Future<bool> isSignedIn() async {
    return (await _getPrefs()).getString('token') != null;
  }
}
