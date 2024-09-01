import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practly/core/config/config.dart';
import 'package:practly/core/user/user_model.dart';
import 'package:practly/core/models/quiz/quiz_model.dart';
import 'package:practly/core/models/speak/speak_out_aloud_model.dart';
import 'package:practly/features/word_of_the_day/data/word_of_the_day_model.dart';

/// DatabaseService handles all interactions with Cloud Firestore.
class DatabaseService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  final Config _config;

  User? get _user => _firebaseAuth.currentUser;

  DatabaseService(
    this._firestore,
    this._firebaseAuth,
    this._config,
  );

  /// Creates a new user profile in Firestore.
  ///
  /// Call this method immediately after a new user signs up.
  ///
  /// Example:
  /// ```dart
  /// await databaseService.createUserProfile(UserModel(
  ///   name: 'John Doe',
  ///   email: 'john@example.com',
  ///   createdAt: DateTime.now(),
  /// ));
  /// ```
  Future<void> createUserProfile(UserModel user) async {
    await _firestore.collection('users').doc(user.id).set(user.toMap());
  }

  /// Retrieves the current user's profile from Firestore.
  ///
  /// Call this method when you need to display or use the user's profile information.
  ///
  /// Example:
  /// ```dart
  /// UserModel? userProfile = await databaseService.getUserProfile();
  /// if (userProfile != null) {
  ///   print('User name: ${userProfile.name}');
  /// }
  /// ```
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

  /// Saves a new Word of the Day to the user's generated content.
  ///
  /// Call this method after generating a new Word of the Day.
  ///
  /// Example:
  /// ```dart
  /// WordOfTheDayModel newWord = await contentGenerationService.generateWordOfTheDay();
  /// await databaseService.saveWordOfTheDay(newWord);
  /// ```
  Future<void> saveWordOfTheDay(WordOfTheDayModel word) async {
    await _firestore
        .collection('users')
        .doc(_user!.uid)
        .collection('generatedContent')
        .doc('wordOfTheDay')
        .collection('words')
        .add(word.toMap());
  }

  /// Saves a new Speak Out Loud sentence to the user's generated content.
  ///
  /// Call this method after generating a new Speak Out Loud sentence.
  ///
  /// Example:
  /// ```dart
  /// SpeakOutAloudModel newSentence = await contentGenerationService.generateSpeakOutLoud();
  /// await databaseService.saveSpeakOutLoud(newSentence);
  /// ```
  Future<void> saveSpeakOutLoud(SpeakOutAloudModel sentence) async {
    await _firestore
        .collection('users')
        .doc(_user!.uid)
        .collection('generatedContent')
        .doc('speakOutLoud')
        .collection('sentences')
        .add(sentence.toMap());
  }

  /// Saves a new Quiz to the user's generated content.
  ///
  /// Call this method after generating a new Quiz.
  ///
  /// Example:
  /// ```dart
  /// QuizModel newQuiz = await contentGenerationService.generateQuiz();
  /// await databaseService.saveQuiz(newQuiz);
  /// ```
  Future<void> saveQuiz(QuizModel quiz) async {
    await _firestore
        .collection('users')
        .doc(_user!.uid)
        .collection('generatedContent')
        .doc('quiz')
        .collection('quizzes')
        .add(quiz.toMap());
  }

  /// Updates the user's subscription information.
  ///
  /// Call this method when a user purchases a subscription or when their subscription status changes.
  ///
  /// Example:
  /// ```dart
  /// await databaseService.updateSubscription('paid', DateTime.now().add(Duration(days: 30)));
  /// ```
  Future<void> updateSubscription(String type, DateTime? expiresAt) async {
    await _firestore.collection('users').doc(_user!.uid).update({
      'subscription.type': type,
      'subscription.expiresAt': expiresAt,
    });
  }

  /// Retrieves the user's current subscription information.
  ///
  /// Call this method when you need to check the user's subscription status.
  ///
  /// Example:
  /// ```dart
  /// Map<String, dynamic>? subscription = await databaseService.getSubscription();
  /// if (subscription != null && subscription['type'] == 'paid') {
  ///   // Unlock premium features
  /// }
  /// ```
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

  /// Retrieves the user's current ad watch count.
  ///
  /// Call this method to check if a user is eligible to watch more ads for rewards.
  ///
  /// Example:
  /// ```dart
  /// int adWatchCount = await databaseService.getAdWatchCount();
  /// if (adWatchCount < 5) {
  ///   // Allow user to watch another ad
  /// } else {
  ///   // Inform user they've reached the daily limit
  /// }
  /// ```
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

  /// Provides a stream of Word of the Day entries for the current user.
  ///
  /// Use this method with a StreamBuilder in your UI to display the user's Word of the Day history.
  ///
  /// Example:
  /// ```dart
  /// StreamBuilder<List<WordOfTheDayModel>>(
  ///   stream: databaseService.getWordOfTheDayStream(),
  ///   builder: (context, snapshot) {
  ///     if (snapshot.hasData) {
  ///       return ListView.builder(
  ///         itemCount: snapshot.data!.length,
  ///         itemBuilder: (context, index) {
  ///           return ListTile(title: Text(snapshot.data![index].word));
  ///         },
  ///       );
  ///     } else {
  ///       return CircularProgressIndicator();
  ///     }
  ///   },
  /// )
  /// ```
  Stream<List<WordOfTheDayModel>> getWordOfTheDayStream() {
    return _firestore
        .collection('users')
        .doc(_user!.uid)
        .collection('generatedContent')
        .doc('wordOfTheDay')
        .collection('words')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                WordOfTheDayModel.fromJson(jsonEncode(doc.data()), null))
            .toList());
  }

  /// Provides a stream of Speak Out Loud entries for the current user.
  ///
  /// Use this method with a StreamBuilder in your UI to display the user's Speak Out Loud history.
  ///
  /// Example:
  /// ```dart
  /// StreamBuilder<List<SpeakOutAloudModel>>(
  ///   stream: databaseService.getSpeakOutLoudStream(),
  ///   builder: (context, snapshot) {
  ///     if (snapshot.hasData) {
  ///       return ListView.builder(
  ///         itemCount: snapshot.data!.length,
  ///         itemBuilder: (context, index) {
  ///           return ListTile(title: Text(snapshot.data![index].sentence));
  ///         },
  ///       );
  ///     } else {
  ///       return CircularProgressIndicator();
  ///     }
  ///   },
  /// )
  /// ```
  Stream<List<SpeakOutAloudModel>> getSpeakOutLoudStream() {
    return _firestore
        .collection('users')
        .doc(_user!.uid)
        .collection('generatedContent')
        .doc('speakOutLoud')
        .collection('sentences')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                SpeakOutAloudModel.fromJson(jsonEncode(doc.data()), null))
            .toList());
  }

  /// Provides a stream of Quiz entries for the current user.
  ///
  /// Use this method with a StreamBuilder in your UI to display the user's Quiz history.
  ///
  /// Example:
  /// ```dart
  /// StreamBuilder<List<QuizModel>>(
  ///   stream: databaseService.getQuizStream(),
  ///   builder: (context, snapshot) {
  ///     if (snapshot.hasData) {
  ///       return ListView.builder(
  ///         itemCount: snapshot.data!.length,
  ///         itemBuilder: (context, index) {
  ///           return ListTile(title: Text(snapshot.data![index].question));
  ///         },
  ///       );
  ///     } else {
  ///       return CircularProgressIndicator();
  ///     }
  ///   },
  /// )
  /// ```
  Stream<List<QuizModel>> getQuizStream() {
    return _firestore
        .collection('users')
        .doc(_user!.uid)
        .collection('generatedContent')
        .doc('quiz')
        .collection('quizzes')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => QuizModel.fromJson(jsonEncode(doc.data())))
            .toList());
  }
}
