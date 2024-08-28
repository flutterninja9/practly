import 'dart:async';

import 'package:practly/core/async/async_notifier.dart';
import 'package:practly/features/quiz/data/quiz_model.dart';
import 'package:practly/features/quiz/data/quiz_repository.dart';

class QuizNotifier extends AsyncNotifier<QuizModel> {
  final QuizRepository _repository;

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

  QuizNotifier(this._repository);

  void generateQuiz() {
    _isAnswerSelected = false;
    _selectedAnswer = null;
    _countdown = 0;
    execute(
      () => _repository.getQuiz(complexity: complexity),
    );
  }

  void startCountdown(int seconds) {
    countdown = seconds;

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        countdown--;
      } else {
        timer.cancel();
        generateQuiz();
      }
    });
  }

  void handleOptionSelected(String selectedOption) {
    _selectedAnswer = selectedOption;
    _isAnswerSelected = true;
    startCountdown(2);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
