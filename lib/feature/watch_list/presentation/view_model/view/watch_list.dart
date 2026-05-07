import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/common/app_bar.dart';
import 'package:movie_app/feature/menu_drawer/view/menu_drawer_screen .dart';
import 'package:movie_app/feature/watch_list/data/local/watch_list_local_data_source.dart';
import 'package:movie_app/feature/watch_list/data/repo/watch_list_repo_imp.dart';
import 'package:movie_app/feature/watch_list/domain/use_case/add_movie_use_case.dart';
import 'package:movie_app/feature/watch_list/domain/use_case/get_all_movies_use_case.dart';
import 'package:movie_app/feature/watch_list/domain/use_case/is_movie_saved_use_case.dart';
import 'package:movie_app/feature/watch_list/domain/use_case/remove_movie_use_case.dart';

import 'package:movie_app/feature/watch_list/presentation/view_model/cubit/watch_list_cubit.dart';
// import 'package:movie_app/feature/watch_list/presentation/view/widgets/watch_list_empty_widget.dart';
import 'package:movie_app/feature/watch_list/presentation/view_model/view/widgets/watch_list_empty_widget.dart';
import 'package:movie_app/feature/watch_list/presentation/view_model/view/widgets/watch_list_movie_item.dart';

class WatchList extends StatelessWidget {
  static const String routeName = "WatchList";
  const WatchList({super.key});

  @override
  Widget build(BuildContext context) {
    final localDataSource = WatchListLocalDataSource();
    final repo = WatchListRepoImp(localDataSource);

    return BlocProvider(
      create: (_) => WatchListCubit(
        addMovieUseCase: AddMovieUseCase(repo),
        removeMovieUseCase: RemoveMovieUseCase(repo),
        getAllMoviesUseCase: GetAllMoviesUseCase(repo),
        isMovieSavedUseCase: IsMovieSavedUseCase(repo),
      )..loadMovies(),
      child: const _WatchListBody(),
    );
  }
}

class _WatchListBody extends StatelessWidget {
  const _WatchListBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      endDrawer: MenuDrawer(),
      appBar: CustomAppBar(title: "Watch List"),
      body: BlocBuilder<WatchListCubit, WatchListState>(
        builder: (context, state) {
          if (state is WatchListEmpty) {
            return const WatchListEmptyWidget();
          }

          if (state is WatchListLoaded) {
            return ListView.builder(
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return WatchListMovieItem(
                  movie: movie,
                  onRemove: () {
                    context.read<WatchListCubit>().toggleMovie(movie);
                  },
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
