import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:practly/di/di.dart';
import 'package:practly/core/navigation/auth_notifier.dart';
import 'package:practly/features/auth/presentation/auth_screen.dart';
import 'package:practly/features/home/presentation/home_screen.dart';
import 'package:practly/features/profile/profile_screen.dart';
import 'package:practly/features/quiz/presentation/quiz_screen.dart';
import 'package:practly/features/speak_out_aloud/presentation/speak_out_aloud_screen.dart';
import 'package:practly/features/word_of_the_day/presentation/word_of_the_day_screen.dart';

class AppRouter {
  GoRouter getRouter = GoRouter(
    initialLocation: AuthScreen.route,
    refreshListenable: locator.get<FirebaseAuthNotifier>(),
    redirect: (BuildContext context, GoRouterState state) {
      final authNotifier = locator.get<FirebaseAuthNotifier>();
      final isSigningIn = state.matchedLocation == AuthScreen.route;

      if (!authNotifier.isSignedIn && !isSigningIn) {
        return AuthScreen.route;
      }

      if (authNotifier.isSignedIn && isSigningIn) {
        return WordOfTheDayScreen.route;
      }

      return null;
    },
    routes: [
      GoRoute(
          path: AuthScreen.route,
          builder: (context, state) {
            return const AuthScreen();
          }),
      GoRoute(
          path: UserProfileScreen.route,
          builder: (context, state) {
            return const UserProfileScreen();
          }),
      ShellRoute(
        builder: (context, state, child) {
          return HomeScreen(child: child);
        },
        routes: [
          // learn
          GoRoute(
            path: WordOfTheDayScreen.route,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: WordOfTheDayScreen()),
          ),
          // speak
          GoRoute(
            path: SpeakOutAloudScreen.route,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: SpeakOutAloudScreen()),
          ),

          // quiz
          GoRoute(
            path: QuizScreen.route,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: QuizScreen()),
          ),
        ],
      ),
    ],
  );
}
