import 'package:day_22/features/activity/activity_screen.dart';
import 'package:day_22/features/home/views/main_screen.dart';
import 'package:day_22/features/home/views/widgets/nav_tab.dart';
import 'package:day_22/features/profile/views/profile_screen.dart';
import 'package:day_22/features/search/views/search_screen.dart';
import 'package:day_22/features/write/views/write_screen.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _currentIndex = 0;
  final screens = [
    const MainScreen(),
    const SearchScreen(),
    Container(),
    const ActivityScreen(),
    const ProfileScreen(),
  ];

  void _onTap(int x) {
    setState(() {
      _currentIndex = x;
    });
  }

  void _onWriteTap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.9,
        child: const WriteScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            height: 1,
          ),
          BottomAppBar(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  NavTab(
                    onTap: () => _onTap(0),
                    isSeleted: _currentIndex == 0,
                    icon: FontAwesomeIcons.house,
                  ),
                  NavTab(
                    onTap: () => _onTap(1),
                    isSeleted: _currentIndex == 1,
                    icon: FontAwesomeIcons.magnifyingGlass,
                  ),
                  NavTab(
                    onTap: _onWriteTap,
                    isSeleted: _currentIndex == 2,
                    icon: FontAwesomeIcons.penToSquare,
                  ),
                  NavTab(
                    onTap: () => _onTap(3),
                    isSeleted: _currentIndex == 3,
                    icon: FontAwesomeIcons.heart,
                  ),
                  NavTab(
                    onTap: () => _onTap(4),
                    isSeleted: _currentIndex == 4,
                    icon: FontAwesomeIcons.user,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
