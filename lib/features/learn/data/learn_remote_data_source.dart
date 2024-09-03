import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:practly/core/enums/enums.dart';
import 'package:practly/core/models/excercise.dart';
import 'package:practly/features/learn/data/lesson_model.dart';
import 'package:practly/features/learn/data/i_learn_remote_data_source.dart';
import 'package:practly/features/learn/data/word_of_the_day_model.dart';

class LearnRemoteDataSourceImpl extends ILearnRemoteDataSource {
  final GoogleGemini _gemini;
  final FirebaseFirestore _firestore;

  LearnRemoteDataSourceImpl(this._gemini, this._firestore);

  @override
  Future<WordOfTheDayModel> generateWordOfTheDay({
    Complexity complexity = Complexity.easy,
  }) async {
    final res = await _gemini.generateFromText(wordGenPrompt(complexity));
    return WordOfTheDayModel.fromJson(res.text, complexity);
  }

  @override
  Future<List<LessonModel>> getLessons({
    Complexity complexity = Complexity.easy,
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
    debugPrint(json.toString());

    return (json).map((e) => Exercise.fromMap(e, Complexity.easy)).toList();
  }
}
