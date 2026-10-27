
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/core/common/app_bar.dart';
import 'package:movie_app/core/di/service_locatore.dart';
import 'package:movie_app/core/utils/app_colors.dart';

import '../../../details/presentation/view/screens/details_movie_screen.dart';
import '../view_model/watch_list_cubit.dart';
import '../view_model/watch_list_state.dart';
import 'widgets/watch_list_movie_card.dart';

class WatchList extends StatefulWidget {
  static const String routeName = 'WatchList';

  const WatchList({super.key});

  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  late final WatchListCubit _watchListCubit;

  @override
  void initState() {
    super.initState();
    _watchListCubit = getIt<WatchListCubit>();
    _watchListCubit.loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WatchListCubit>.value(
      value: _watchListCubit,
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: CustomAppBar(title: 'Watch List'),
        body: BlocBuilder<WatchListCubit, WatchListState>(
          builder: (context, state) {
            if (state is WatchListInitial || state is WatchListLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFC9A96E),
                ),
              );
            }

            if (state is WatchListError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.redAccent,
                        size: 42,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColor.primaryTextColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          _watchListCubit.loadMovies();
                        },
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is WatchListLoaded) {
              if (state.movies.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.bookmark_border_rounded,
                          size: 72,
                          color: AppColor.SecoundryTextColor,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Your Watch List Is Empty',
                          style: TextStyle(
                            color: AppColor.primaryTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Save your favorite movies to find them here.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.SecoundryTextColor,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.movies.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final movie = state.movies[index];

                  return Dismissible(
                    key: ValueKey(movie.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 24),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    onDismissed: (_) {
                      _watchListCubit.removeMovie(movie.id);
                    },
                    child: WatchListMovieCard(
                      movie: movie,
                      onRemove: () {
                        _watchListCubit.removeMovie(movie.id);
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (_) => DetailsMovieScreen(id: movie.id),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
