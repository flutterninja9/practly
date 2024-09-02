import 'package:cloud_firestore/cloud_firestore.dart';
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
    final res = await _gemini.generateFromText(prompt(complexity));
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
  Future<List<Exercise>> getExercises(String id) async {
    final doc = await _firestore
        .collection('lessons')
        .doc(id)
        .collection("exercises")
        .get();

    return (doc.docs)
        .map((e) => Exercise.fromMap(e.data(), Complexity.easy))
        .toList();
  }
}
