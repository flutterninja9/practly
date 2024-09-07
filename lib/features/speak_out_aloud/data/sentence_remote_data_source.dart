import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:practly/core/enums/enums.dart';
import 'package:practly/core/models/used_content_model.dart';
import 'package:practly/features/speak_out_aloud/data/i_sentence_remote_data_source.dart';
import 'package:practly/core/models/speak/speak_out_aloud_model.dart';

class SentenceRemoteDataSource extends ISentenceRemoteDataSource {
  final GoogleGemini _gemini;
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  SentenceRemoteDataSource(
    this._gemini,
    this._firebaseAuth,
    this._firestore,
  );

  @override
  Future<SpeakOutAloudModel> generateSentence({
    Complexity? complexity,
  }) async {
    final usedContent = await _getUsedContent();
    final unUsedContent = await _getUnusedContent(
      usedContent,
      complexity ?? Complexity.easy,
    );

    if (unUsedContent.isNotEmpty) {
      unUsedContent.shuffle();
      final randomElement = unUsedContent.first;
      await _addToUsedContent(randomElement.toUsedContent());
      return randomElement;
    }

    // fallback to gemini here
    final generatedSentence =
        await _generateSentenceFromGemini(complexity, usedContent);
    final generatedSentenceWithId = await _saveToGlobalPool(generatedSentence);
    await _addToUsedContent(generatedSentenceWithId.toUsedContent());

    return generatedSentenceWithId;
  }

  Future<SpeakOutAloudModel> _generateSentenceFromGemini(
    Complexity? complexity,
    List<UsedContentModel> usedContent,
  ) async {
    final res = await _gemini.generateFromText(
      prompt(
        complexity ?? Complexity.easy,
        blacklist: usedContent.map((e) => e.generation).toList(),
      ),
    );

    return SpeakOutAloudModel.fromJson(res.text);
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

  Future<List<SpeakOutAloudModel>> _getUnusedContent(
    List<UsedContentModel> usedContent,
    Complexity complexity,
  ) async {
    final usedIds = usedContent.map((e) => e.usedContentId).toList();

    final res = await _firestore
        .collection("sentencePool")
        .where(FieldPath.fromString("complexity"), isEqualTo: complexity.name)
        .get();

    return res.docs
        .map((e) => SpeakOutAloudModel.fromFirestoreMap(e.id, e.data()))
        .where((e) => !usedIds.contains(e.id))
        .toList();
  }

  /// returns the element with id
  Future<SpeakOutAloudModel> _saveToGlobalPool(SpeakOutAloudModel word) async {
    final res = await _firestore.collection("sentencePool").add(word.toMap());

    return word.copyWith(id: res.id);
  }
}
