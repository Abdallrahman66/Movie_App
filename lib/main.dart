import 'package:flutter/material.dart';
import 'package:movie_app/feature/watch_list/data/watch_list_storage.dart';
import 'package:movie_app/app_section/app_section_view.dart';
import 'package:movie_app/core/di/service_locatore.dart';
import 'package:movie_app/feature/home/presentation/view/home_screen.dart';
import 'package:movie_app/feature/onboarding/presentation/onboarding_screen.dart';
import 'package:movie_app/feature/onboarding/presentation/splash_screen.dart';
import 'package:movie_app/feature/search/presentation/view/screen/Search_screen.dart';

import 'package:movie_app/feature/watch_list/presentation/view/watch_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await WatchListStorage.initialize();

  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: SplashScreen.routeName,

      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),

        OnboardingScreen.routeName: (context) => const OnboardingScreen(),

        AppSectionView.routeName: (context) => const AppSectionView(),

        HomeScreen.routeName: (context) => const HomeScreen(),

        SearchScreen.routeName: (context) => const SearchScreen(),

        WatchList.routeName: (context) => const WatchList(),
      },
    );
  }
}
