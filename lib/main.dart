import 'package:flutter/material.dart';
import 'package:movie_app/app_section/app_section_view.dart';

import 'package:movie_app/core/di/service_locatore.dart';


import 'package:movie_app/feature/details/presentation/view/screens/details_movie_screen.dart';

import 'package:movie_app/feature/home/presentation/view/home_screen.dart';
import 'package:movie_app/feature/search/presentation/view/screen/Search_screen.dart';

import 'package:movie_app/feature/search/presentation/view/screen/invalid_search_screen.dart';
import 'package:movie_app/feature/watch_list/presentation/view/watch_list.dart';



void main() async {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppSectionView.routeName,
      routes: {
        AppSectionView.routeName: (context) => const AppSectionView(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        SearchScreen.routeName: (context) => const SearchScreen(),
        InvalidSearchScreen.routeName: (context) => const InvalidSearchScreen(),
        DetailsMovieScreen.routeName: (context) =>
            const DetailsMovieScreen(id: 254473),
        WatchList.routeName: (context) => const WatchList(),
      },
    );
  }
}
