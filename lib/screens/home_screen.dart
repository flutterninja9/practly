import 'package:flutter/material.dart';
import 'package:practly/screens/speak_out_aloud_screen.dart';
import 'package:practly/screens/word_of_the_day_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const WordOfTheDayScreen(),
    const SpeakOutAloudScreen(),
  ];

  final List<BottomNavigationBarItem> _navItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.school),
      label: 'Learn',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.record_voice_over),
      label: 'Speak',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpeakEase'),
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
          selectedIndex: _selectedIndex,
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
          child: _screens[_selectedIndex],
        ),
      ],
    );
  }

  Widget _buildNarrowLayout() {
    return Column(
      children: [
        Expanded(
          child: _screens[_selectedIndex],
        ),
        BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: _navItems,
        ),
      ],
    );
  }
}
