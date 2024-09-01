import 'dart:async';

import 'package:flutter/material.dart';
import 'package:practly/features/quiz/data/quiz_model.dart';

class QuizExcerciseViewModel with ChangeNotifier {
  final QuizModel model;

  QuizExcerciseViewModel(this.model);

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

  int _countdown = 0;

  int get countdown => _countdown;

  set countdown(int value) {
    _countdown = value;

    notifyListeners();
  }

  Timer? timer;

  void startCountdown(int seconds, Function() onDone) {
    countdown = seconds;

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        countdown--;
      } else {
        timer.cancel();
        onDone();
      }
    });
  }

  void handleOptionSelected(String selectedOption, Function() onRequestNext) {
    _selectedAnswer = selectedOption;
    _isAnswerSelected = true;
    startCountdown(2, onRequestNext);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
