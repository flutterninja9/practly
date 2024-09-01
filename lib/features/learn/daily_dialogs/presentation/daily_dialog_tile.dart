import 'package:flutter/material.dart';
import 'package:practly/features/learn/data/daily_dialogs_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ScenarioTile extends StatelessWidget {
  final DailyDialogModel model;
  final VoidCallback? onTap;

  const ScenarioTile({
    super.key,
    required this.model,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.title,
              style: ShadTheme.of(context).textTheme.h4,
            ),
            const SizedBox(height: 8),
            Text(
              model.description,
              style: ShadTheme.of(context).textTheme.p,
            ),
            const SizedBox(height: 12),
            ShadButton.secondary(
              onPressed: onTap,
              child: const Text('Practice'),
            ),
          ],
        ),
      ),
    );
  }
}
