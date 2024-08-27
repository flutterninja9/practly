import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:practly/core/enums/enums.dart';
import 'package:practly/di/di.dart';
import 'package:practly/core/services/gemini_service.dart';
import 'package:practly/features/word_of_the_day/data/word_of_the_day_model.dart';

class WordOfTheDayScreen extends StatefulWidget {
  const WordOfTheDayScreen({super.key});

  @override
  State<WordOfTheDayScreen> createState() => _WordOfTheDayScreenState();
}

class _WordOfTheDayScreenState extends State<WordOfTheDayScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late final FlutterTts _flutterTts;

  WordOfTheDayModel? wordOfTheDay;
  bool _isLoading = false;
  WordComplexity _complexity = WordComplexity.easy;

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _generateWord();
  }

  Future<void> _generateWord() async {
    setState(() {
      _isLoading = true;
    });
    _animationController.forward(from: 0.0);

    try {
      final result = await locator
          .get<GenerationService>()
          .generateWordOfTheDay(complexity: _complexity);
      _parseResponse(result);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error generating word')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _parseResponse(String response) {
    setState(() {
      wordOfTheDay = WordOfTheDayModel.fromJson(response);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Word of the Day',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              _buildComplexitySelector(),
              const SizedBox(height: 20),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _buildWordContent(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _isLoading ? null : _generateWord,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                    child: const Text('Generate New Word'),
                  ),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _speakSentence,
                    child: const Text('Hear Word'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _speakSentence() async {
    if (wordOfTheDay != null && (wordOfTheDay?.word ?? '').isNotEmpty) {
      await _flutterTts.speak(wordOfTheDay!.word);
    }
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
        _generateWord();
      },
    );
  }

  Widget _buildWordContent() {
    return SingleChildScrollView(
      child: FadeTransition(
        opacity: _animation,
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  wordOfTheDay!.word,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                Text(
                  wordOfTheDay!.definition,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 20),
                Text(
                  'Example:',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.blue[700]),
                ),
                Text(wordOfTheDay!.example,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontStyle: FontStyle.italic)),
                const SizedBox(height: 20),
                Text(
                  'Usage:',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.blue[700]),
                ),
                Text(wordOfTheDay!.usage,
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
