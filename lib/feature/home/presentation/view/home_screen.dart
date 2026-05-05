import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/di/service_locatore.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/widgets/cache_networkImage_widget.dart';
import 'package:movie_app/feature/details/presentation/view/details_movie_screen.dart';
import 'package:movie_app/feature/home/presentation/view_model/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "HomeScreen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..getRecommendedMovie(),
      child: Scaffold(
        backgroundColor: const Color(0xff111114),
        appBar: AppBar(backgroundColor: const Color(0xff111114)),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: SizedBox());
            }

            if (state is HomeSuccesses) {
              final recommended = state.recommendedMovieEntity.results;
              final popular = state.recommendedMovieEntity.results;
              final releases = state.recommendedMovieEntity.results;

              return CustomScrollView(
                slivers: [
                  /// Recommended
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child: Text(
                        "Recommended",
                        style: TextStyle(
                          color: AppColor.primaryTextColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 260,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: recommended.length,
                        itemBuilder: (context, index) {
                          final movie = recommended[index];

                          final imageUrl = movie.posterPath.isNotEmpty
                              ? "https://image.tmdb.org/t/p/w500${movie.posterPath}"
                              : "https://via.placeholder.com/150";

                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                DetailsMovieScreen.routeName,
                                arguments: movie.id,
                              );
                            },
                            child: Container(
                              width: 160,
                              margin: const EdgeInsets.all(10),
                              child: CacheNetworkImage(
                                imageUrl: imageUrl,
                                fit: BoxFit.cover,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  /// Popular
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child: Text(
                        "Popular",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 260,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: popular.length,
                        itemBuilder: (context, index) {
                          final movie = popular[index];

                          final imageUrl = movie.posterPath.isNotEmpty
                              ? "https://image.tmdb.org/t/p/w500${movie.posterPath}"
                              : "https://via.placeholder.com/150";

                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                DetailsMovieScreen.routeName,
                                arguments: movie.id,
                              );
                            },
                            child: Container(
                              width: 160,
                              margin: const EdgeInsets.all(10),
                              child: CacheNetworkImage(
                                imageUrl: imageUrl,
                                fit: BoxFit.cover,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  /// Releases
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child: Text(
                        "Releases",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 260,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: releases.length,
                        itemBuilder: (context, index) {
                          final movie = releases[index];

                          final imageUrl = movie.posterPath.isNotEmpty
                              ? "https://image.tmdb.org/t/p/w500${movie.posterPath}"
                              : "https://via.placeholder.com/150";

                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                DetailsMovieScreen.routeName,
                                arguments: movie.id,
                              );
                            },
                            child: Container(
                              width: 160,
                              margin: const EdgeInsets.all(10),
                              child: CacheNetworkImage(
                                imageUrl: imageUrl,
                                fit: BoxFit.cover,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }

            if (state is HomeError) {
              return Center(
                child: Text(
                  state.messageError,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }

            return SizedBox();
          },
        ),
      ),
    );
  }
}
