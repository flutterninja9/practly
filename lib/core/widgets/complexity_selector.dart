import 'package:flutter/material.dart';

import 'package:practly/core/enums/enums.dart';

class ComplexitySelector extends StatelessWidget {
  const ComplexitySelector({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  final WordComplexity initialValue;
  final Function(WordComplexity) onChanged;
  @override
  Widget build(BuildContext context) {
    return SegmentedButton<WordComplexity>(
      segments: const [
        ButtonSegment(value: WordComplexity.easy, label: Text('Easy')),
        ButtonSegment(value: WordComplexity.medium, label: Text('Medium')),
        ButtonSegment(value: WordComplexity.hard, label: Text('Hard')),
      ],
      selected: {initialValue},
      onSelectionChanged: (Set<WordComplexity> newSelection) {
        onChanged(newSelection.first);
      },
    );
  }
}
