import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authProvider = Provider((ref) => Authenticator(ref));

final authStateProvider = StateProvider((ref) => AuthState.loading);

enum AuthState { loading, signedIn, signedOut }

class Authenticator {
  SharedPreferences? _prefs;
  final ProviderRef ref;

  int attempts = 0;

  Authenticator(this.ref) {
    ref.read(authStateProvider.notifier).state = AuthState.loading;
    _isSignedIn().then((signed) => {
          ref.read(authStateProvider.notifier).state =
              (signed ? AuthState.signedIn : AuthState.signedOut)
        });
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    ref.read(authStateProvider.notifier).state = AuthState.loading;
    if (attempts.isOdd) {
      return Future.delayed(const Duration(seconds: 2)).then((value) async {
        ref.read(authStateProvider.notifier).state = AuthState.signedIn;
        (await _getPrefs()).setString('token', '123');
      });
    }
    attempts++;
    ref.read(authStateProvider.notifier).state = AuthState.signedOut;
    return Future.delayed(const Duration(seconds: 1),
        throw Exception("Incorrect email or password"));
  }

  Future<void> signOut() {
    ref.read(authStateProvider.notifier).state = AuthState.loading;
    return Future.delayed(const Duration(seconds: 1)).then((value) =>
        ref.read(authStateProvider.notifier).state = AuthState.signedOut);
  }

  Future<bool> _isSignedIn() async {
    return (await _getPrefs()).getString('token') != null;
  }

  Future<SharedPreferences> _getPrefs() async {
    if (_prefs != null) return _prefs!;
    return _prefs = await SharedPreferences.getInstance();
  }
}
