import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ForceUpdateScreen extends StatelessWidget {
  const ForceUpdateScreen({super.key});

  static String get route => "/update-required";
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
                'Update Required',
                style: ShadTheme.of(context).textTheme.h1,
              ),
              const SizedBox(height: 20),
              ShadCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      LucideIcons.download,
                      size: 64,
                      color: ShadTheme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'New Version Available',
                      style: ShadTheme.of(context).textTheme.h3,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'A new version of the app is available. Please update to continue.',
                      style: ShadTheme.of(context).textTheme.small,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ShadButton(
                      onPressed: () {
                        launchUrlString(
                          "https://play.google.com/store/apps/details?id=in.bloomsoft.speakease",
                        );
                      },
                      child: const Text('Update Now'),
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
