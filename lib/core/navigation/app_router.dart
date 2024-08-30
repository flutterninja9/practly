import 'package:go_router/go_router.dart';
import 'package:practly/features/home/presentation/home_screen.dart';
import 'package:practly/features/quiz/presentation/quiz_screen.dart';
import 'package:practly/features/speak_out_aloud/presentation/speak_out_aloud_screen.dart';
import 'package:practly/features/word_of_the_day/presentation/word_of_the_day_screen.dart';

class AppRouter {
  GoRouter getRouter = GoRouter(
    initialLocation: WordOfTheDayScreen.route,
    routes: [
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
