import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/core/di/service_locatore.dart';
import 'package:movie_app/core/utils/app_colors.dart';

import 'package:movie_app/feature/details/presentation/view/screens/details_movie_screen.dart';
import 'package:movie_app/feature/home/domain/entity/home_movie_entity.dart';
import 'package:movie_app/feature/home/presentation/view_model/home_cubit.dart';
import 'package:movie_app/feature/home/presentation/widget/home_loading_shimmer.dart';
import 'package:movie_app/feature/home/presentation/widget/home_movie_card.dart';
import 'package:movie_app/feature/home/presentation/widget/recommended.dart';

import '../widget/home_top_animation.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color _goldColor = Color(0xFFC9A96E);

  List<MovieItemEntity> recommended = [];
  List<MovieItemEntity> popular = [];
  List<MovieItemEntity> releases = [];

  String? recommendedError;
  String? popularError;
  String? releasesError;

  final Set<String> _completedRequests = {};

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>()
        ..getRecommendedMovie()
        ..getPopolureMovie()
        ..getReleasesMovie(),
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColor.backgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          titleSpacing: 0,
          toolbarHeight: 84,
          title: const HomeTopAnimation(),
        ),
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: _handleHomeState,
          builder: (context, state) {
            final hasMovies =
                recommended.isNotEmpty ||
                popular.isNotEmpty ||
                releases.isNotEmpty;

            if (!hasMovies && _completedRequests.length < 3) {
              return const Center(child: HomeLoadingShimmer());
            }

            return RefreshIndicator(
              onRefresh: () => _refreshHome(context),
              color: AppColor.primaryTextColor,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  _buildSectionHeader('Recommended'),

                  SliverToBoxAdapter(
                    child: _buildSectionMessage(recommendedError),
                  ),

                  SliverToBoxAdapter(
                    child: RecommendedMovieCarousel(
                      movies: recommended,
                      onMovieTap: (movie) {
                        _openMovieDetails(context, movie.id);
                      },
                    ),
                  ),

                  _buildSectionHeader('Popular'),

                  SliverToBoxAdapter(child: _buildSectionMessage(popularError)),

                  SliverToBoxAdapter(
                    child: _buildMovieList(context: context, movies: popular),
                  ),

                  _buildSectionHeader('Releases'),

                  SliverToBoxAdapter(
                    child: _buildSectionMessage(releasesError),
                  ),

                  SliverToBoxAdapter(
                    child: _buildMovieList(context: context, movies: releases),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleHomeState(BuildContext context, HomeState state) {
    if (state is HomeRecommendedSuccesses) {
      recommended = state.recommendedMovieEntity.results;
      recommendedError = null;
      _completedRequests.add('recommended');
    } else if (state is HomePopolureSuccesses) {
      popular = state.popolureMovieEntity.results;
      popularError = null;
      _completedRequests.add('popular');
    } else if (state is HomeReleasesSuccesses) {
      releases = state.releasesMovieEntity.results;
      releasesError = null;
      _completedRequests.add('releases');
    } else if (state is HomeRecommendedError) {
      recommendedError = state.messageError;
      _completedRequests.add('recommended');
    } else if (state is HomePopolureError) {
      popularError = state.messageError;
      _completedRequests.add('popular');
    } else if (state is HomeReleasesError) {
      releasesError = state.messageError;
      _completedRequests.add('releases');
    }
  }

  Future<void> _refreshHome(BuildContext context) async {
    final cubit = context.read<HomeCubit>();

    setState(() {
      _completedRequests.clear();

      recommendedError = null;
      popularError = null;
      releasesError = null;
    });

    await Future.wait([
      cubit.getRecommendedMovie(),
      cubit.getPopolureMovie(),
      cubit.getReleasesMovie(),
    ]);
  }

  SliverToBoxAdapter _buildSectionHeader(String title) {
    return SliverToBoxAdapter(child: _buildSectionTitle(title));
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 22, 16, 14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.primaryTextColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 64,
            height: 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: [Color(0x00C9A96E), _goldColor, Color(0x00C9A96E)],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionMessage(String? error) {
    if (error == null || error.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        error,
        style: const TextStyle(color: Colors.redAccent, fontSize: 14),
      ),
    );
  }

  Widget _buildMovieList({
    required BuildContext context,
    required List<MovieItemEntity> movies,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.sizeOf(context).width;

        final cardWidth = screenWidth < 360
            ? 130.0
            : screenWidth < 600
            ? 145.0
            : screenWidth < 900
            ? 160.0
            : 175.0;

        final cardHeight = (cardWidth * 1.45) + 75;

        if (movies.isEmpty) {
          return SizedBox(height: cardHeight);
        }

        return SizedBox(
          height: cardHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: movies.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final movie = movies[index];

              return HomeMovieCard(
                key: ValueKey(movie.id),
                movie: movie,
                width: cardWidth,
                animationDelay: Duration(milliseconds: index * 70),
                onTap: () {
                  _openMovieDetails(context, movie.id);
                },
              );
            },
          ),
        );
      },
    );
  }

  void _openMovieDetails(BuildContext context, int movieId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailsMovieScreen(id: movieId)),
    );
  }
}
