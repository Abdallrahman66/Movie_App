import 'package:flutter/material.dart';
import 'package:movie_app/core/common/bottom_navigation%20_bar.dart';
import 'package:movie_app/feature/search/presentation/view/Search_screen.dart';
import 'package:movie_app/feature/home/presentation/view/home_screen.dart';

import 'package:movie_app/feature/watch_list/presentation/view/watch_list.dart';

class AppSectionView extends StatefulWidget {
  static const String routeName = "AppSectionView";
  const AppSectionView({super.key});

  @override
  State<AppSectionView> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AppSectionView> {
  int _currentIndex = 0;

  final List<Widget> _screens =const [HomeScreen(), SearchScreen(), WatchList()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],

      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
