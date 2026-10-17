import 'package:flutter/material.dart';

import '../feature/home/presentation/view/home_screen.dart';
import '../feature/reels/reels_screen.dart';
import '../feature/search/presentation/view/screen/search_screen.dart';
import '../feature/watch_list/presentation/view/watch_list.dart';

class AppSectionView extends StatefulWidget {
  static const String routeName = "AppSectionView";

  const AppSectionView({super.key});

  @override
  State<AppSectionView> createState() => _AppSectionViewState();
}

class _AppSectionViewState extends State<AppSectionView> {
  int _currentIndex = 0;

  bool _isBottomBarVisible = true;
  double _lastScrollOffset = 0;

  static const Color barColor = Color(0xFF19191F);
  static const Color selectedColor = Color(0xFFC9A96E);
  static const Color unselectedColor = Color(0xFF85858D);

  final List<Widget> _screens = const [
    HomeScreen(),
    ReleasesScreen(),
    SearchScreen(),
    WatchList(),
  ];

  void _handleScroll(ScrollNotification notification) {
    if (notification is! ScrollUpdateNotification) return;

    final currentOffset = notification.metrics.pixels;
    final difference = currentOffset - _lastScrollOffset;

    if (difference > 3 && _isBottomBarVisible) {
      setState(() {
        _isBottomBarVisible = false;
      });
    } else if (difference < -3 && !_isBottomBarVisible) {
      setState(() {
        _isBottomBarVisible = true;
      });
    }

    _lastScrollOffset = currentOffset;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: barColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                _handleScroll(notification);
                return false;
              },
              child: IndexedStack(index: _currentIndex, children: _screens),
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            left: 12,
            right: 12,
            bottom: _isBottomBarVisible ? 20 : -90,
            child: IgnorePointer(
              ignoring: !_isBottomBarVisible,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _isBottomBarVisible ? 1 : 0,
                child: Container(
                  height: 62,
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildItem(Icons.home_outlined, 0),
                      _buildItem(Icons.movie_outlined, 1),
                      _buildItem(Icons.search, 2),
                      _buildItem(Icons.bookmark_border, 3),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(IconData icon, int index) {
    return IconButton(
      onPressed: () {
        setState(() {
          _currentIndex = index;
          _isBottomBarVisible = true;
          _lastScrollOffset = 0;
        });
      },
      icon: Icon(
        icon,
        size: 25,
        color: _currentIndex == index ? selectedColor : unselectedColor,
      ),
    );
  }
}
