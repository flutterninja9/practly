import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:practly/common/enums.dart';
import 'package:practly/service_locator/service_locator.dart';
import 'package:practly/services/gemini_service.dart';

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

  String _word = '';
  String _definition = '';
  String _example = '';
  String _usage = '';
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
      _word = 'Loading...';
      _definition = '';
      _example = '';
      _usage = '';
    });
    _animationController.forward(from: 0.0);

    try {
      final result = await locator
          .get<GenerationService>()
          .generateWordOfTheDay(complexity: _complexity);
      _parseResponse(result);
    } catch (e) {
      setState(() {
        _word = 'Error';
        _definition = 'Failed to generate word. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _parseResponse(String response) {
    final lines = response.split('\n');
    setState(() {
      for (var line in lines) {
        if (line.startsWith('Word:')) {
          _word = line.substring(5).trim();
        } else if (line.startsWith('Definition:')) {
          _definition = line.substring(11).trim();
        } else if (line.startsWith('Example:')) {
          _example = line.substring(8).trim();
        } else if (line.startsWith('Usage:')) {
          _usage = line.substring(6).trim();
        }
      }
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
    if (_word.isNotEmpty) {
      await _flutterTts.speak(_word);
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
                  _word,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                Text(
                  _definition,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 20),
                Text(
                  'Example:',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.blue[700]),
                ),
                Text(_example,
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
                Text(_usage, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
