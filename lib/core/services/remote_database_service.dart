import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practly/core/config/config.dart';
import 'package:practly/core/models/excercise.dart';
import 'package:practly/core/navigation/auth_notifier.dart';
import 'package:practly/core/user/user_model.dart';
import 'package:practly/di/di.dart';

class RemoteDatabaseService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  final Config _config;

  User? get _user => _firebaseAuth.currentUser;

  RemoteDatabaseService(
    this._firestore,
    this._firebaseAuth,
    this._config,
  );

  Future<void> createUserProfile(UserModel user) async {
    await _firestore.collection('users').doc(user.id).set(user.toMap());
  }

  Future<void> updateUserProfile(
    String userId,
    Map<String, String> updates,
  ) async {
    await _firestore.collection('users').doc(userId).update(updates);
  }

  Future<UserModel?> getUserProfile(String userId) async {
    DocumentSnapshot doc =
        await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      return UserModel.fromMap(
        id: userId,
        doc.data() as Map<String, dynamic>,
      );
    }
    return null;
  }

  Future<void> updateSubscription(String type, DateTime? expiresAt) async {
    await _firestore.collection('users').doc(_user!.uid).update({
      'subscription.type': type,
      'subscription.expiresAt': expiresAt,
    });
  }

  Future<Map<String, dynamic>?> getSubscription() async {
    DocumentSnapshot doc =
        await _firestore.collection('users').doc(_user!.uid).get();
    return (doc.data() as Map<String, dynamic>)['subscription'];
  }

  Future<void> decrementGenerationLimit() async {
    await _firestore
        .collection('users')
        .doc(_user!.uid)
        .update({'subscription.generationLimit': FieldValue.increment(-1)});
  }

  Future<void> updateGenerationLimit() async {
    await _firestore.collection('users').doc(_user!.uid).update({
      'subscription.generationLimit': FieldValue.increment(
        _config.creditsForAdWatch,
      )
    });
  }

  Future<int> getGenerationLimit() async {
    DocumentSnapshot doc =
        await _firestore.collection('users').doc(_user!.uid).get();
    return (doc.data() as Map<String, dynamic>)['subscription']
            ['generationLimit'] ??
        0;
  }

  Stream<int> getGenerationLimitStream() {
    return _firestore.collection('users').doc(_user!.uid).snapshots().map((e) =>
        (e.data() as Map<String, dynamic>)['subscription']['generationLimit'] ??
        0);
  }

  Future<void> setEnrollment(String lessonId) async {
    await _firestore.collection('users').doc(_user!.uid).update({
      'progress.currentLesson': lessonId,
    });
  }

  Future<void> clearEnrollment() async {
    await _firestore.collection('users').doc(_user!.uid).update({
      'progress': FieldValue.delete(),
    });
  }

  Future<List<Exercise>?> getCachedExercise(String lessonId) async {
    final res =
        (await _firestore.collection('users').doc(_user!.uid).get()).data();

    final inProgressExercises = res?["progress"]["excercises"] as List?;

    return inProgressExercises?.map((e) => Exercise.fromMap(e)).toList();
  }

  Future<void> setCachedExercise(List<Exercise> exercises) async {
    await _firestore.collection('users').doc(_user!.uid).update({
      'progress.excercises': exercises.map((e) => e.toMap()).toList(),
    });
  }

  Future<void> markAsDone(String lessonId) async {
    await clearEnrollment();
    final authNotifier = locator.get<FirebaseAuthNotifier>();
    final user = await getUserProfile(authNotifier.signedInUser!.id);
    authNotifier.signedInUser = user;
  }
}
