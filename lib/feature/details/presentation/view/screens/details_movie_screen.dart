import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/core/common/app_bar.dart';
import 'package:movie_app/core/common/custem_action_bookmark_icon%20.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/utils/assets_icons.dart';

import 'package:movie_app/feature/details/presentation/view/widgets/similar_movies_section.dart';
import 'package:movie_app/feature/details/presentation/view/widgets/view_movie_widget.dart';
import 'package:movie_app/feature/details/presentation/view_model/details_cubit.dart';

import '../../../domain/use_case/get_details_use_case.dart';
import '../../../domain/use_case/get_similar_use_case.dart'
    show getSimilarUseCaseInject;

class DetailsMovieScreen extends StatefulWidget {
  const DetailsMovieScreen({super.key, required this.id});

  static const String routeName = 'DetailsMovieScreen';

  final int id;

  @override
  State<DetailsMovieScreen> createState() => _DetailsMovieScreenState();
}

class _DetailsMovieScreenState extends State<DetailsMovieScreen> {
  late final DetailsCubit _cubit;

  static const Color _gold = Color(0xFFC9A96E);

  @override
  void initState() {
    super.initState();

    _cubit = DetailsCubit(
      getDetailsUseCaseInject(),
      getSimilarUseCaseInject(),
      widget.id,
    );

    _cubit.getData(widget.id);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailsCubit>.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: CustomAppBar(
          title: 'Film Detail',
          leading: IconButton(
            tooltip: 'Back',
            icon: Image.asset(
              AssetsIcon.back_button_icon,
              width: 20,
              height: 20,
            ),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          actions: [CustomActionBookmark(id: widget.id)],
        ),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: BlocBuilder<DetailsCubit, DetailsState>(
                bloc: _cubit,
                buildWhen: (_, state) =>
                    state is DetailsLoadingState ||
                    state is DetailsSuccessState ||
                    state is DetailsErrorState,
                builder: (context, state) {
                  if (state is DetailsLoadingState || state is DetailsInitial) {
                    return const SizedBox(
                      height: 300,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: _gold,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  }

                  if (state is DetailsErrorState) {
                    return _buildError(state.error, onRetry: _cubit.getDetails);
                  }

                  final movie = _cubit.movie;

                  if (movie == null) {
                    return _buildError(
                      'Movie details are unavailable.',
                      onRetry: _cubit.getDetails,
                    );
                  }

                  return ViewMovieWidget(movieDetails: movie);
                },
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 28)),

            SliverToBoxAdapter(
              child: BlocBuilder<DetailsCubit, DetailsState>(
                bloc: _cubit,
                buildWhen: (_, state) =>
                    state is SimilarLoadingState ||
                    state is SimilarSuccessState ||
                    state is SimilarErrorState,
                builder: (context, state) {
                  if (state is SimilarLoadingState) {
                    return const Padding(
                      padding: EdgeInsets.all(28),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: _gold,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  }

                  if (state is SimilarErrorState) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Could not load similar movies.',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: _cubit.getSimilar,
                            child: const Text(
                              'Retry',
                              style: TextStyle(color: _gold),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is SimilarSuccessState) {
                    return SimilarMoviesSection(
                      movies: _cubit.similarMovies,
                      onMovieTap: (movieId) {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => DetailsMovieScreen(id: movieId),
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 30)),
          ],
        ),
      ),
    );
  }

  Widget _buildError(String message, {required VoidCallback onRetry}) {
    return SizedBox(
      height: 280,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.movie_filter_outlined,
                color: Colors.white54,
                size: 38,
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 14),
              OutlinedButton.icon(
                onPressed: onRetry,
                style: OutlinedButton.styleFrom(
                  foregroundColor: _gold,
                  side: const BorderSide(color: _gold),
                ),
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Try again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
