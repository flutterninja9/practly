import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:practly/common/enums.dart';
import 'package:practly/service_locator/service_locator.dart';
import 'package:practly/services/gemini_service.dart';

class SpeakOutAloudScreen extends StatefulWidget {
  const SpeakOutAloudScreen({super.key});

  @override
  State<SpeakOutAloudScreen> createState() => _SpeakOutAloudScreenState();
}

class _SpeakOutAloudScreenState extends State<SpeakOutAloudScreen> {
  WordComplexity _complexity = WordComplexity.easy;
  String _sentence = '';
  String _explanation = '';
  String _pronunciationTip = '';
  bool _isLoading = false;
  late final FlutterTts _flutterTts;

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
    _generateSentence();
  }

  Future<void> _generateSentence() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await locator
          .get<GenerationService>()
          .generateSentence(complexity: _complexity);
      _parseSentenceResponse(response);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error generating sentence')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _parseSentenceResponse(String response) {
    final Map<String, dynamic> data = json.decode(response);
    setState(() {
      _sentence = data['sentence'] ?? '';
      _explanation = data['explanation'] ?? '';
      _pronunciationTip = data['tip'] ?? '';
    });
  }

  Future<void> _speakSentence() async {
    if (_sentence.isNotEmpty) {
      await _flutterTts.speak(_sentence);
    }
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
              'Speak Out Aloud',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            _buildComplexitySelector(),
            const SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _buildSentenceContent(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _isLoading ? null : _generateSentence,
                  child: const Text('Generate New Sentence'),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _speakSentence,
                  child: const Text('Hear Sentence'),
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
        _generateSentence();
      },
    );
  }

  Widget _buildSentenceContent() {
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
          Text(
            'Explanation:',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(_explanation),
          const SizedBox(height: 20),
          Text(
            'Pronunciation Tip:',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(_pronunciationTip),
        ],
      ),
    );
  }
}
