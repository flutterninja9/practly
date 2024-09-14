import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:practly/core/complexity_selector/presentation/complexity_selector_screen.dart';
import 'package:practly/core/config/config.dart';
import 'package:practly/core/services/app_info_service.dart';
import 'package:practly/core/widgets/force_update_screen.dart';
import 'package:practly/core/widgets/maintainence_screen.dart';
import 'package:practly/di/di.dart';
import 'package:practly/core/navigation/auth_notifier.dart';
import 'package:practly/features/auth/presentation/auth_screen.dart';
import 'package:practly/features/home/presentation/home_screen.dart';
import 'package:practly/features/learn/daily_challenge/presentation/challenge_screen.dart';
import 'package:practly/features/learn/data/challenge_model.dart';
import 'package:practly/features/learn/data/lesson_model.dart';
import 'package:practly/features/learn/exercise/presentation/exercise_screen.dart';
import 'package:practly/features/learn/presentation/learn_screen.dart';
import 'package:practly/features/profile/profile_screen.dart';
import 'package:practly/features/quiz/presentation/quiz_screen.dart';
import 'package:practly/features/speak_out_aloud/presentation/speak_out_aloud_screen.dart';

class AppRouter {
  GoRouter getRouter = GoRouter(
    initialLocation: AuthScreen.route,
    refreshListenable: locator.get<FirebaseAuthNotifier>(),
    redirect: (BuildContext context, GoRouterState state) async {
      final config = locator.get<Config>();
      final appInfo = locator.get<AppInfoService>();
      final authNotifier = locator.get<FirebaseAuthNotifier>();
      final noComplexityChosen = authNotifier.signedInUser?.complexity == null;
      final inMaintainence = config.inMaintainence;
      final authAndOnboardingScreens = [
        AuthScreen.route,
        ComplexitySelectorScreen.route
      ];
      final isSigningIn =
          authAndOnboardingScreens.contains(state.matchedLocation);

      if (inMaintainence) {
        return MaintenanceScreen.route;
      }

      if (await appInfo.isUpdateRequired()) {
        return ForceUpdateScreen.route;
      }

      if (!authNotifier.isSignedIn && !isSigningIn) {
        return AuthScreen.route;
      }

      if (authNotifier.isSignedIn && isSigningIn) {
        if (noComplexityChosen) {
          return ComplexitySelectorScreen.route;
        }

        return LearnScreen.route;
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
      GoRoute(
          path: ExerciseScreen.route,
          builder: (context, state) {
            return ExerciseScreen(
              id: state.pathParameters["id"]!,
              lessonModel: state.extra as LessonModel?,
            );
          }),
      GoRoute(
          path: ChallengeScreen.route,
          builder: (context, state) {
            return ChallengeScreen(
              challengeModel: state.extra as ChallengeModel,
            );
          }),
      GoRoute(
          path: ComplexitySelectorScreen.route,
          builder: (context, state) {
            return const ComplexitySelectorScreen();
          }),
      ShellRoute(
        builder: (context, state, child) {
          return HomeScreen(child: child);
        },
        routes: [
          // learn
          GoRoute(
            path: LearnScreen.route,
            pageBuilder: (context, state) =>
                NoTransitionPage(child: LearnScreen()),
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
      GoRoute(
        path: MaintenanceScreen.route,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: MaintenanceScreen());
        },
      ),
      GoRoute(
        path: ForceUpdateScreen.route,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: ForceUpdateScreen());
        },
      ),
    ],
  );
}
