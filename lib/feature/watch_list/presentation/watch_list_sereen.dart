import 'package:flutter/material.dart';

import 'package:movie_app/feature/menu_drawer/view/menu_drawer_screen%20.dart';

import 'package:movie_app/core/common/app_bar.dart';
import 'package:movie_app/feature/watch_list/presentation/view_model/view/widgets/watch_list_empty_widget.dart';

class WatchList extends StatelessWidget {
  static const String routeName = "WatchList";
  const WatchList({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.black,
      endDrawer: MenuDrawer(),
      appBar: CustomAppBar(title: "Watch List"),
      body: const WatchListEmptyWidget(),
    );
  }
}
