import 'package:flutter/material.dart';
import 'package:practly/core/constants.dart';
import 'package:practly/core/mixins/feature_toggle_mixin.dart';
import 'package:practly/core/navigation/auth_notifier.dart';
import 'package:practly/core/widgets/header.dart';
import 'package:practly/core/async/async_page.dart';
import 'package:practly/di/di.dart';
import 'package:practly/features/learn/daily_dialogs/buisness_logic/daily_dialogs_notifier.dart';
import 'package:practly/features/learn/daily_dialogs/presentation/lesson_tile.dart';

class DailyDialogsScreen extends StatefulWidget {
  const DailyDialogsScreen({super.key});

  @override
  State<DailyDialogsScreen> createState() => _DailyDialogsScreenState();
}

class _DailyDialogsScreenState extends State<DailyDialogsScreen>
    with SingleTickerProviderStateMixin, FeatureToggleMixin {
  late final DailyDialogsNotifier notifier;
  late final FirebaseAuthNotifier authNotifier;

  @override
  void initState() {
    super.initState();
    notifier = locator.get<DailyDialogsNotifier>();
    authNotifier = locator.get<FirebaseAuthNotifier>();
    notifier.getDailyDialogs();
  }

  @override
  Widget build(BuildContext context) {
    if (!isEnabled(kDialyDialogFeatureConstant)) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Header(title: 'Daily dialogues'),
        const SizedBox(height: 20),
        AnimatedBuilder(
          animation: notifier,
          builder: (context, child) {
            return AsyncPage(
              asyncValue: notifier.state,
              dataBuilder: (model) {
                final someLessonOngoing =
                    authNotifier.signedInUser?.progress?.currentLesson != null;

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: model.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final lesson = model[index];
                    final alreadyEnrolled = notifier.alreadyEnrolled(lesson.id);

                    return LessonTile(
                      model: lesson,
                      alreadyEnrolled: alreadyEnrolled,
                      lessonLocked: someLessonOngoing && !alreadyEnrolled,
                      onTap: () async =>
                          await notifier.onStartLesson(lesson, context),
                    );
                  },
                );
              },
              onRetry: notifier.getDailyDialogs,
            );
          },
        ),
      ],
    );
  }
}
