import 'package:flutter/material.dart';
import 'package:movie_app/core/common/app_bar.dart';

import 'package:movie_app/feature/menu_drawer/view/menu_drawer_screen%20.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = "SearchScreen";
  const SearchScreen({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      endDrawer: MenuDrawer(),
      appBar: CustomAppBar(title: "Search"),
    );
  }
}
