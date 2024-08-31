import 'package:flutter/material.dart';
import 'package:practly/core/extensions/context_extensions.dart';
import 'package:practly/core/services/ad_service.dart';
import 'package:practly/di/di.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class OutOfCreditsWidget extends StatefulWidget {
  final Function() onAdSeen;

  const OutOfCreditsWidget({super.key, required this.onAdSeen});

  @override
  State<OutOfCreditsWidget> createState() => _OutOfCreditsWidgetState();
}

class _OutOfCreditsWidgetState extends State<OutOfCreditsWidget> {
  late final AdService _adService;

  @override
  void initState() {
    _adService = locator.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ShadImage.square(size: 64, LucideIcons.coins),
            const SizedBox(height: 24),
            Text(
              'Out of Free Generations',
              style: ShadTheme.of(context).textTheme.h3,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'You\'ve used all your free generations for now. Watch a short ad to earn more!',
              style: ShadTheme.of(context).textTheme.small,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ShadButton(
              onPressed: () async {
                await _adService.loadAndShowRewardedAd(widget.onAdSeen);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShadImage.square(
                    size: 20,
                    LucideIcons.play,
                    color: context.isDarkMode ? Colors.black : Colors.white,
                  ),
                  const SizedBox(width: 8),
                  const Text('Watch Ad'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
