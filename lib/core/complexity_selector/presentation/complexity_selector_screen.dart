import 'package:flutter/material.dart';
import 'package:practly/core/complexity_selector/business_logic/complexity_selector_notifier.dart';
import 'package:practly/core/complexity_selector/presentation/complexity_selector.dart';
import 'package:practly/core/extensions/context_extensions.dart';
import 'package:practly/di/di.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ComplexitySelectorScreen extends StatefulWidget {
  const ComplexitySelectorScreen({super.key});

  static String get route => "/complexity-selector";

  @override
  State<ComplexitySelectorScreen> createState() =>
      _ComplexitySelectorScreenState();
}

class _ComplexitySelectorScreenState extends State<ComplexitySelectorScreen> {
  late final ComplexitySelectorNotifier notifier;

  @override
  void initState() {
    notifier = locator.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: AnimatedBuilder(
            animation: notifier,
            builder: (context, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Center(
                    child: Icon(LucideIcons.shapes, size: 80),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Customize Your Learning Path',
                    style: ShadTheme.of(context).textTheme.h3,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Adjust your learning experience based on word complexity:',
                    style: ShadTheme.of(context).textTheme.large,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Choose a difficulty level to generate content that suits your learning needs. You can always change this later in your profile settings.',
                    style: ShadTheme.of(context).textTheme.list,
                  ),
                  const SizedBox(height: 24),
                  ComplexitySelector(
                    initialValue: notifier.selectedComplexity,
                    onChanged: notifier.onComplexityChanged,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: ShadButton(
                          onPressed: notifier.isSaving
                              ? null
                              : () => notifier.onSaveAndContinue(),
                          child: notifier.isSaving
                              ? SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: context.isDarkMode
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                )
                              : const Text('Save & Continue'),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }
}
