import 'package:flutter/material.dart';
import 'package:practly/core/models/quiz/quiz_model.dart';

class QuizExcerciseViewModel with ChangeNotifier {
  final QuizModel model;
  final bool autoNext;

  QuizExcerciseViewModel(this.model, this.autoNext);

  String? _selectedAnswer;

  String? get selectedAnswer => _selectedAnswer;

  set selectedAnswer(String? value) {
    _selectedAnswer = value;

    notifyListeners();
  }

  bool _isAnswerSelected = false;

  bool get isAnswerSelected => _isAnswerSelected;

  set isAnswerSelected(bool value) {
    _isAnswerSelected = value;

    notifyListeners();
  }

  void handleOptionSelected(String selectedOption, Function() onRequestNext) {
    _selectedAnswer = selectedOption;
    isAnswerSelected = true;
    if (autoNext) {
      onRequestNext();
    }
  }
}
