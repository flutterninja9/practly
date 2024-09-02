import 'package:flutter/material.dart';
import 'package:practly/core/enums/enums.dart';
import 'package:practly/core/extensions/string_extensions.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ComplexitySelector extends StatelessWidget {
  const ComplexitySelector({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  final Complexity initialValue;
  final Function(Complexity) onChanged;

  @override
  Widget build(BuildContext context) {
    return ShadSelect(
      minWidth: 180,
      initialValue: initialValue.name,
      onChanged: (String? newValue) {
        if (newValue != null) {
          onChanged(Complexity.values.firstWhere((e) => e.name == newValue));
        }
      },
      placeholder: const Text('Select a difficulty level'),
      options: Complexity.values
          .map(
            (e) => ShadOption(value: e.name, child: Text(e.name.capitalize())),
          )
          .toList(),
      selectedOptionBuilder: (context, value) {
        return Text(value.capitalize());
      },
    );
  }
}
