import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practly/features/word_of_the_day/presentation/word_of_the_day_screen.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  static String get route => "/maintainence";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Maintenance',
                style: ShadTheme.of(context).textTheme.h1,
              ),
              const SizedBox(height: 20),
              ShadCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      LucideIcons.wrench,
                      size: 64,
                      color: ShadTheme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Under Maintenance',
                      style: ShadTheme.of(context).textTheme.h2,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'We\'re working on improving our service. Please check back later.',
                      style: ShadTheme.of(context).textTheme.small,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ShadButton(
                      onPressed: () {
                        context.go(WordOfTheDayScreen.route);
                      },
                      child: const Text('Refresh'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
