import 'package:flutter/material.dart';
import 'package:practly/core/constants.dart';
import 'package:practly/core/mixins/feature_toggle_mixin.dart';
import 'package:practly/core/widgets/header.dart';
import 'package:practly/core/async/async_page.dart';
import 'package:practly/di/di.dart';
import 'package:practly/features/learn/daily_dialogs/buisness_logic/daily_dialogs_notifier.dart';
import 'package:practly/features/learn/daily_dialogs/presentation/daily_dialog_tile.dart';

class DailyDialogsScreen extends StatefulWidget {
  const DailyDialogsScreen({super.key});

  @override
  State<DailyDialogsScreen> createState() => _DailyDialogsScreenState();
}

class _DailyDialogsScreenState extends State<DailyDialogsScreen>
    with SingleTickerProviderStateMixin, FeatureToggleMixin {
  late final DailyDialogsNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = locator.get<DailyDialogsNotifier>();
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
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: model.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final scenario = model[index];

                    return ScenarioTile(model: scenario);
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
