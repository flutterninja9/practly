import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:practly/core/config/config.dart';
import 'package:practly/core/services/remote_database_service.dart';
import 'package:practly/core/user/user_model.dart';
import 'package:practly/di/di.dart';

class AuthState extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RemoteDatabaseService _databaseService = locator.get();
  final Config _config = locator.get();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool isLoading = false;
  bool obscure = false;
  String? errorMessage;

  bool get allowAnonymousSignups => _config.allowAnonymousSignups;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setObscure(bool value) {
    obscure = value;
    notifyListeners();
  }

  void setErrorMessage(String? message) {
    errorMessage = message;
    notifyListeners();
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      setLoading(true);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      setErrorMessage(null);
    } on FirebaseAuthException catch (e) {
      setErrorMessage(e.message);
    } finally {
      setLoading(false);
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      setLoading(true);
      final creds = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (creds.additionalUserInfo?.isNewUser ?? false) {
        await _databaseService.createUserProfile(
          UserModel.fromEmailAndId(
            id: creds.user!.uid,
            creditsForNewUser: _config.creditsForNewUser,
            email: creds.user?.email,
            name: creds.user?.displayName,
            dpUrl: creds.user?.photoURL,
          ),
        );
      }
      setErrorMessage(null);
    } on FirebaseAuthException catch (e) {
      setErrorMessage(e.message);
    } finally {
      setLoading(false);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      setLoading(true);
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final creds = await _auth.signInWithCredential(credential);

      if (creds.additionalUserInfo?.isNewUser ?? false) {
        await _databaseService.createUserProfile(
          UserModel.fromEmailAndId(
            id: creds.user!.uid,
            creditsForNewUser: _config.creditsForNewUser,
            email: creds.user?.email,
            name: creds.user?.displayName,
            dpUrl: creds.user?.photoURL,
          ),
        );
      }
      setErrorMessage(null);
    } catch (e) {
      setErrorMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> signInAnonymously() async {
    try {
      setLoading(true);
      final creds = await _auth.signInAnonymously();

      if (creds.additionalUserInfo?.isNewUser ?? false) {
        await _databaseService.createUserProfile(
          UserModel.fromEmailAndId(
            id: creds.user!.uid,
            creditsForNewUser: _config.creditsForNewUser,
            email: creds.user?.email,
            name: creds.user?.displayName,
            dpUrl: creds.user?.photoURL,
          ),
        );
      }
      setErrorMessage(null);
    } catch (e) {
      setErrorMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }
}
