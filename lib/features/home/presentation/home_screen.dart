import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:practly/core/extensions/context_extensions.dart';
import 'package:practly/core/user/user_model.dart';
import 'package:practly/features/home/widgets/credits_remaining_widget.dart';
import 'package:practly/features/home/widgets/profile_pic.dart';
import 'package:practly/features/learn/presentation/learn_screen.dart';
import 'package:practly/features/quiz/presentation/quiz_screen.dart';
import 'package:practly/features/speak_out_aloud/presentation/speak_out_aloud_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.child,
  });

  final Widget child;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final UserModel userModel;

  int _getSelectedIndex() {
    final currentRoute = context.currentRoute;

    if (currentRoute.contains(LearnScreen.route)) {
      return 0;
    }
    if (currentRoute.contains(SpeakOutAloudScreen.route)) {
      return 1;
    }
    if (currentRoute.contains(QuizScreen.route)) {
      return 2;
    }

    throw UnsupportedError("$currentRoute is invalid");
  }

  final List<BottomNavigationBarItem> _navItems = const [
    BottomNavigationBarItem(
      icon: Icon(LucideIcons.school),
      label: 'Learn',
    ),
    BottomNavigationBarItem(
      icon: Icon(LucideIcons.mic2),
      label: 'Speak',
    ),
    BottomNavigationBarItem(
      icon: Icon(LucideIcons.clipboardList),
      label: 'Quiz',
    ),
  ];

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        context.go(LearnScreen.route);
      case 1:
        context.go(SpeakOutAloudScreen.route);
      case 2:
        context.go(QuizScreen.route);
      default:
        throw UnsupportedError("Invalid action");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpeakEase'),
        actions: const [CreditsRemainingWidget(), ProfilePic()],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 600) {
            return _buildWideLayout();
          } else {
            return _buildNarrowLayout();
          }
        },
      ),
    );
  }

  Widget _buildWideLayout() {
    return Row(
      children: [
        NavigationRail(
          selectedIndex: _getSelectedIndex(),
          onDestinationSelected: _onItemTapped,
          labelType: NavigationRailLabelType.all,
          destinations: _navItems
              .map((item) => NavigationRailDestination(
                    icon: item.icon,
                    label: Text(item.label!),
                  ))
              .toList(),
        ),
        const VerticalDivider(thickness: 1, width: 1),
        Expanded(
          child: widget.child,
        ),
      ],
    );
  }

  Widget _buildNarrowLayout() {
    return Column(
      children: [
        Expanded(
          child: widget.child,
        ),
        BottomNavigationBar(
          currentIndex: _getSelectedIndex(),
          selectedItemColor: context.isDarkMode ? Colors.white : Colors.black,
          unselectedItemColor:
              context.isDarkMode ? Colors.white38 : Colors.black38,
          onTap: _onItemTapped,
          items: _navItems,
        ),
      ],
    );
  }
}
