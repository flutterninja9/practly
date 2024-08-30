import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthState extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool isLoading = false;
  bool obscure = false;
  String? errorMessage;

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
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
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
      await _auth.signInWithCredential(credential);
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
      await _auth.signInAnonymously();
      setErrorMessage(null);
    } catch (e) {
      setErrorMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }
}
