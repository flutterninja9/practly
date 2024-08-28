// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HighlightedLabel extends StatelessWidget {
  const HighlightedLabel({
    super.key,
    required this.label,
  });

  final String label;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: ShadTheme.of(context).textTheme.large.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.blue[700],
            height: 1.7,
          ),
    );
  }
}
