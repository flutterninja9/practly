// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:practly/core/widgets/highlighted_label.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HighlightedSection extends StatelessWidget {
  const HighlightedSection({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HighlightedLabel(label: title),
        Text(content, style: ShadTheme.of(context).textTheme.small),
      ],
    );
  }
}
