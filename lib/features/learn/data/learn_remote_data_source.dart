import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:practly/core/enums/enums.dart';
import 'package:practly/core/models/excercise.dart';
import 'package:practly/core/models/used_content_model.dart';
import 'package:practly/features/learn/data/lesson_model.dart';
import 'package:practly/features/learn/data/i_learn_remote_data_source.dart';
import 'package:practly/core/models/word/word_of_the_day_model.dart';

class LearnRemoteDataSourceImpl extends ILearnRemoteDataSource {
  final GoogleGemini _gemini;
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  LearnRemoteDataSourceImpl(
    this._gemini,
    this._firestore,
    this._firebaseAuth,
  );

  @override
  Future<WordOfTheDayModel> generateWordOfTheDay({
    Complexity? complexity,
  }) async {
    final usedContent = await _getUsedContent();
    final unUsedContent = await _getUnusedContent(usedContent);
    if (unUsedContent.isNotEmpty) {
      unUsedContent.shuffle();
      final randomElement = unUsedContent.first;
      await _addToUsedContent(randomElement.toUsedContent());
      return randomElement;
    }

    // fallback to gemini here
    final generatedWord =
        await _generateWordFromGemini(complexity, usedContent);
    final generatedWordWithId = await _saveToGlobalPool(generatedWord);
    await _addToUsedContent(generatedWordWithId.toUsedContent());

    return generatedWordWithId;
  }

  Future<WordOfTheDayModel> _generateWordFromGemini(
    Complexity? complexity,
    List<UsedContentModel> usedContent,
  ) async {
    final res = await _gemini.generateFromText(
      wordGenPrompt(
        complexity ?? Complexity.easy,
        blacklist: usedContent.map((e) => e.generation).toList(),
      ),
    );

    return WordOfTheDayModel.fromJson(res.text);
  }

  Future<List<UsedContentModel>> _getUsedContent() async {
    final userId = _firebaseAuth.currentUser!.uid;

    final res = await _firestore
        .collection("users")
        .doc(userId)
        .collection("usedContent")
        .get();

    return res.docs.map((e) => UsedContentModel.fromMap(e.data())).toList();
  }

  Future<void> _addToUsedContent(UsedContentModel content) async {
    final userId = _firebaseAuth.currentUser!.uid;

    await _firestore
        .collection("users")
        .doc(userId)
        .collection("usedContent")
        .add(content.toMap());
  }

  Future<List<WordOfTheDayModel>> _getUnusedContent(
    List<UsedContentModel> usedContent,
  ) async {
    final usedIds = usedContent.map((e) => e.usedContentId).toList();

    final res = await _firestore.collection("wordPool").get();

    return res.docs
        .map((e) => WordOfTheDayModel.fromMap(e.id, e.data()))
        .where((e) => !usedIds.contains(e.id))
        .toList();
  }

  /// returns the element with id
  Future<WordOfTheDayModel> _saveToGlobalPool(WordOfTheDayModel word) async {
    final res = await _firestore.collection("wordPool").add(word.toMap());

    return word.copyWith(id: res.id);
  }

  @override
  Future<List<LessonModel>> getLessons({
    Complexity? complexity = Complexity.easy,
  }) async {
    final doc = await _firestore.collection('lessons').get();

    return (doc.docs)
        .map((e) => LessonModel.fromMap(e.id, e.data(), complexity))
        .toList();
  }

  @override
  Future<List<Exercise>> getExercises({
    Complexity complexity = Complexity.easy,
    required LessonModel lesson,
  }) async {
    final res = await _gemini.generateFromText(
      excerciseGenPrompt(lesson, complexity),
    );
    final json = jsonDecode(res.text) as List;

    return (json).map((e) => Exercise.fromMap(e, Complexity.easy)).toList();
  }
}
