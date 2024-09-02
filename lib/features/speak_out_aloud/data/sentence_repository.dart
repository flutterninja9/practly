import 'package:practly/core/enums/enums.dart';
import 'package:practly/features/speak_out_aloud/data/i_sentence_remote_data_source.dart';
import 'package:practly/core/models/speak/speak_out_aloud_model.dart';

class SentenceRepository {
  final ISentenceRemoteDataSource _remoteDataSource;

  SentenceRepository(this._remoteDataSource);

  Future<SpeakOutAloudModel> getSentence({
    Complexity? complexity,
  }) async {
    return _remoteDataSource.generateSentence(
      complexity: complexity ?? Complexity.easy,
    );
  }
}
