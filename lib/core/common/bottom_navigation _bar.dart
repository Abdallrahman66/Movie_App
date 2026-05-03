import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/utils/assets_icons.dart';

class CustomBottomNavigationBar extends StatelessWidget {
 
  final int selectedIndex;
  final Function(int) onDestinationSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            );
          }
          return const TextStyle(color: Colors.grey, fontSize: 12);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: Colors.blue);
          }
          return const IconThemeData(color: Colors.grey);
        }),
      ),
      child: NavigationBar(
        backgroundColor: AppColor.barColor,
        indicatorColor: Colors.transparent,
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected, // بنبعت الـ index للي بره
        destinations: <Widget>[
          const NavigationDestination(
            selectedIcon: Icon(Icons.home, color: Colors.blue),
            icon: Icon(Icons.home_outlined, color: Colors.grey),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Image.asset(AssetsIcon.search_icon, color: Colors.grey),
            selectedIcon: Image.asset(
              AssetsIcon.search_icon,
              color: Colors.blue,
            ),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Image.asset(AssetsIcon.home_icon, color: Colors.grey),
            selectedIcon: const Icon(
              Icons.account_balance_sharp,
              color: Colors.blue,
            ),
            label: 'Watch List',
          ),
        ],
      ),
    );
  }
}
