import 'package:flutter/material.dart';
import 'package:movie_app/app_section/app_section_view.dart';
import 'package:movie_app/feature/details/presentation/view/details_movie_screen.dart';
import 'package:movie_app/feature/home/presentation/view/home_screen.dart';
import 'package:movie_app/feature/search/presentation/view/screen/Search_screen.dart';

import 'package:movie_app/feature/search/presentation/view/screen/invalid_search_screen.dart';
import 'package:movie_app/feature/watch_list/presentation/view/watch_list.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/feature/search/data/api/search_remote_data_source.dart';
import 'package:movie_app/feature/search/data/repo/search_repository_imp.dart';

import 'package:movie_app/feature/search/domain/use_case/search_movies_use_case.dart';

import 'package:movie_app/feature/search/presentation/view_model/cubit/search_cubit.dart';

void main() async {
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
        SearchScreen.routeName: (context) => BlocProvider(
          create: (context) => SearchCubit(
            SearchMoviesUseCase(SearchRepositoryImpl(SearchRemoteDataSource())),
          ),
          child: const SearchScreen(),
        ),
        InvalidSearchScreen.routeName: (context) => const InvalidSearchScreen(),
        DetailsMovieScreen.routeName: (context) => const DetailsMovieScreen(),
        WatchList.routeName: (context) => const WatchList(),
      },
    );
  }
}
