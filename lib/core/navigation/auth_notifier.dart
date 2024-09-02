import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:practly/core/services/database_service.dart';
import 'package:practly/core/user/user_model.dart';
import 'package:practly/di/di.dart';

class FirebaseAuthNotifier extends ChangeNotifier {
  FirebaseAuthNotifier(this._auth) {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  final FirebaseAuth _auth;
  final DatabaseService _databaseService = locator.get();

  void _onAuthStateChanged(User? user) async {
    if (user != null) {
      signedInUser = await _databaseService.getUserProfile(user.uid);
    }
    notifyListeners();
  }

  bool get isSignedIn => _auth.currentUser != null;

  UserModel? _signedInUser;

  UserModel? get signedInUser => _signedInUser;

  set signedInUser(UserModel? value) {
    _signedInUser = value;
  }

  void updateSignedInUserNotify(UserModel? value) {
    signedInUser = value;

    notifyListeners();
  }
}
