import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthNotifier extends ChangeNotifier {
  FirebaseAuthNotifier() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _onAuthStateChanged(User? user) {
    notifyListeners();
  }

  bool get isSignedIn => _auth.currentUser != null;

  User? get signedInUser => _auth.currentUser;
}
