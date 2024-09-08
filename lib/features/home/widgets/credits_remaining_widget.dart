import 'package:flutter/material.dart';
import 'package:practly/core/user/user_service.dart';
import 'package:practly/di/di.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CreditsRemainingWidget extends StatelessWidget {
  const CreditsRemainingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShadBadge.outline(
      child: StreamBuilder<int>(
          stream: locator.get<UserService>().getGenerationLimitStream(),
          initialData: 0,
          builder: (context, snapshot) {
            return Text('${snapshot.data} Credits');
          }),
    );
  }
}
