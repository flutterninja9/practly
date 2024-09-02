import 'package:practly/core/enums/enums.dart';
import 'package:practly/core/models/excercise.dart';
import 'package:practly/features/learn/data/lesson_model.dart';
import 'package:practly/features/learn/data/i_learn_remote_data_source.dart';
import 'package:practly/features/learn/data/word_of_the_day_model.dart';

class LearnRepository {
  final ILearnRemoteDataSource _remoteDataSource;

  LearnRepository(this._remoteDataSource);

  Future<WordOfTheDayModel> getWord({
    Complexity complexity = Complexity.easy,
  }) {
    return _remoteDataSource.generateWordOfTheDay(complexity: complexity);
  }

  Future<List<LessonModel>> getDailyDialogs({
    Complexity complexity = Complexity.easy,
  }) {
    return _remoteDataSource.getLessons(complexity: complexity);
  }

  Future<List<Exercise>> getExercises(String id) {
    return _remoteDataSource.getExercises(id);
  }
}
