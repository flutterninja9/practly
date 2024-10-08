import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practly/core/config/config.dart';
import 'package:practly/core/extensions/datetime_exensions.dart';
import 'package:practly/core/models/excercise.dart';
import 'package:practly/core/navigation/auth_notifier.dart';
import 'package:practly/core/user/daily_challenge_model.dart';
import 'package:practly/core/user/user_model.dart';
import 'package:practly/di/di.dart';

/// Has methods to mutate the currently logged in user object
class UserService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  final Config _config;

  User? get _user => _firebaseAuth.currentUser;

  UserService(
    this._firestore,
    this._firebaseAuth,
    this._config,
  );

  Future<void> createProfile(UserModel user) async {
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

  Future<void> decrementGenerationLimit() async {
    await _firestore
        .collection('users')
        .doc(_user!.uid)
        .update({'subscription.generationLimit': FieldValue.increment(-1)});
  }

  Future<void> updateGenerationLimit({int? by}) async {
    await _firestore.collection('users').doc(_user!.uid).update({
      'subscription.generationLimit': FieldValue.increment(
        by ?? _config.creditsForAdWatch,
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

  Future<DailyChallengeModel?> getDailyChallenge() async {
    final today = DateTime.now().isoCurrentDate;

    final optedChallenges = await _firestore
        .collection("users")
        .doc(_user!.uid)
        .collection("dailyChallenges")
        .where("attemptedOn", isEqualTo: today)
        .get();

    if (optedChallenges.docs.isNotEmpty) {
      final doc = optedChallenges.docs.first;
      return DailyChallengeModel.fromMapAndId(doc.id, doc.data());
    }

    return null;
  }

  Future<DailyChallengeModel> setDailyChallenge(
    DailyChallengeModel challenge,
  ) async {
    // map the fresh content with user data
    final withAttemptDate = challenge.copyWith(
      attemptedOn: DateTime.now(),
      attempts: 1,
    );

    final res = await _firestore
        .collection("users")
        .doc(_user!.uid)
        .collection("dailyChallenges")
        .add(withAttemptDate.toMap());

    return withAttemptDate.copyWith(id: res.id);
  }

  Future<void> markDailyChallengeComplete(String challengeId) async {
    await _firestore
        .collection("users")
        .doc(_user!.uid)
        .collection("dailyChallenges")
        .doc(challengeId)
        .update({
      "completed": true,
      "completedOn": DateTime.now().isoCurrentDate,
    });
  }

  Future<void> updateAttempts(String challengeId, int attemptNumber) async {
    await _firestore
        .collection("users")
        .doc(_user!.uid)
        .collection("dailyChallenges")
        .doc(challengeId)
        .update({"attempts": attemptNumber});
  }
}
