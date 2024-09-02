import 'package:flutter/material.dart';
import 'package:practly/features/learn/data/lesson_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class LessonTile extends StatelessWidget {
  final LessonModel model;
  final bool alreadyEnrolled;
  final bool alreadyCompleted;
  final bool lessonLocked;
  final VoidCallback? onTap;

  const LessonTile({
    super.key,
    required this.model,
    required this.lessonLocked,
    required this.alreadyCompleted,
    required this.alreadyEnrolled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      padding: const EdgeInsets.all(16),
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
          if (alreadyCompleted)
            ShadButton.ghost(
              onPressed: onTap,
              icon: const Icon(LucideIcons.rotateCw),
              child: const Text('Retest'),
            )
          else if (lessonLocked)
            const ShadButton.outline(
              icon: Icon(LucideIcons.lock),
              child: Text('Locked'),
            )
          else if (alreadyEnrolled)
            ShadButton.raw(
              onPressed: onTap,
              variant: ShadButtonVariant.primary,
              child: const Text('Continue'),
            )
          else
            ShadButton.secondary(
              onPressed: onTap,
              child: const Text('Practice'),
            ),
        ],
      ),
    );
  }
}
