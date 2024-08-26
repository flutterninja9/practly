import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:practly/common/enums.dart';
import 'package:practly/service_locator/service_locator.dart';
import 'package:practly/services/gemini_service.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  WordComplexity _complexity = WordComplexity.easy;
  String _sentence = '';
  Map<String, String> _options = {};
  String _correctAnswer = '';
  String? _selectedAnswer;
  bool _isLoading = false;
  bool _isAnswerSelected = false;
  int _countdown = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _generateQuiz();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer if it exists
    super.dispose();
  }

  Future<void> _generateQuiz() async {
    setState(() {
      _isLoading = true;
      _isAnswerSelected = false;
      _selectedAnswer = null;
      _countdown = 0;
    });

    try {
      final response = await locator
          .get<GenerationService>()
          .generateQuiz(complexity: _complexity);
      _parseQuizResponse(response);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating quiz: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _parseQuizResponse(String response) {
    log(response);
    final Map<String, dynamic> data = jsonDecode(response);

    setState(() {
      _sentence = data['sentence'] ?? '';
      _options = Map<String, String>.from(data['options'] ?? {});
      _correctAnswer = data['correct_answer'] ?? '';
    });
  }

  void _handleOptionSelected(String selectedOption) {
    setState(() {
      _selectedAnswer = selectedOption;
      _isAnswerSelected = true;
      _startCountdown(2);
    });
  }

  void _startCountdown(int seconds) {
    setState(() {
      _countdown = seconds;
    });

    _timer?.cancel(); // Cancel any previous timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        setState(() {
          _countdown--;
        });
      } else {
        timer.cancel();
        _generateQuiz(); // Move to the next question
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quiz',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            _buildComplexitySelector(),
            const SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _buildQuizContent(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _generateQuiz,
                  icon: const Icon(Icons.skip_next),
                  label: const Text('Skip'),
                ),
                if (_isAnswerSelected && _countdown > 0)
                  Center(
                    child: Text(
                      'Next question in $_countdown seconds...',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComplexitySelector() {
    return SegmentedButton<WordComplexity>(
      segments: const [
        ButtonSegment(value: WordComplexity.easy, label: Text('Easy')),
        ButtonSegment(value: WordComplexity.medium, label: Text('Medium')),
        ButtonSegment(value: WordComplexity.hard, label: Text('Hard')),
      ],
      selected: {_complexity},
      onSelectionChanged: (Set<WordComplexity> newSelection) {
        setState(() {
          _complexity = newSelection.first;
        });
        _generateQuiz();
      },
    );
  }

  Widget _buildQuizContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _sentence,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ..._options.entries.map((entry) {
            final bool isSelected = _selectedAnswer == entry.key;
            final bool isCorrect = entry.key == _correctAnswer;
            final Color? tileColor = _isAnswerSelected
                ? (isCorrect
                    ? const Color(0xFFA5D6A7)
                    : isSelected
                        ? const Color(0xFFEF9A9A)
                        : null)
                : null;

            return ListTile(
              title: Text('${entry.key}) ${entry.value}'),
              tileColor: tileColor,
              onTap: _isAnswerSelected
                  ? null
                  : () => _handleOptionSelected(entry.key),
            );
          }),
        ],
      ),
    );
  }
}
