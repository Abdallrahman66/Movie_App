import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/di/service_locatore.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/widgets/cache_networkImage_widget.dart';
import 'package:movie_app/feature/details/presentation/view/screens/details_movie_screen.dart';

import 'package:movie_app/feature/home/presentation/view_model/home_cubit.dart';
import 'package:movie_app/feature/home/presentation/widget/home_loading_shimmer.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List recommended = [];
  List popular = [];
  List releases = [];
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()
        ..getRecommendedMovie()
        ..getPopolureMovie()
        ..getReleasesMovie(),

      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,

        appBar: AppBar(backgroundColor: AppColor.backgroundColor),

        body: BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomeRecommendedSuccesses) {
              recommended = state.recommendedMovieEntity.results;
            }

            if (state is HomePopolureSuccesses) {
              popular = state.popolureMovieEntity.results;
            }

            if (state is HomeReleasesSuccesses) {
              releases = state.releasesMovieEntity.results;
            }

            if (recommended.isNotEmpty ||
                popular.isNotEmpty ||
                releases.isNotEmpty) {
              isLoading = false;
            }

            setState(() {});
          },

          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (isLoading &&
                  recommended.isEmpty &&
                  popular.isEmpty &&
                  releases.isEmpty) {
                return Center(child: HomeLoadingShimmer());
              }

              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child: Text(
                        "Recommended",
                        style: TextStyle(
                          color: AppColor.primaryTextColor,
                          fontSize: 22,
                          fontWeight: .bold,
                        ),
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 260,
                      child: ListView.builder(
                        scrollDirection: .horizontal,
                        itemCount: recommended.length,
                        itemBuilder: (context, index) {
                          final movie = recommended[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return DetailsMovieScreen(id: movie.id);
                                  },
                                ),
                              );
                            },
                            child: Container(
                              width: 160,
                              margin: EdgeInsets.all(10),
                              child: CacheNetworkImage(
                                imageUrl: movie.posterPath,
                                fit: .cover,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child: Text(
                        "Popular",
                        style: TextStyle(
                          color: AppColor.primaryTextColor,
                          fontSize: 22,
                          fontWeight: .bold,
                        ),
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 260,
                      child: ListView.builder(
                        scrollDirection: .horizontal,
                        itemCount: popular.length,
                        itemBuilder: (context, index) {
                          final movie = popular[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return DetailsMovieScreen(id: movie.id);
                                  },
                                ),
                              );
                            },
                            child: Container(
                              width: 160,
                              margin: EdgeInsets.all(10),
                              child: CacheNetworkImage(
                                imageUrl: movie.posterPath,
                                fit: .cover,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child: Text(
                        "Releases",
                        style: TextStyle(
                          color: AppColor.primaryTextColor,
                          fontSize: 22,
                          fontWeight: .bold,
                        ),
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 260,
                      child: ListView.builder(
                        scrollDirection: .horizontal,
                        itemCount: releases.length,
                        itemBuilder: (context, index) {
                          final movie = releases[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return DetailsMovieScreen(id: movie.id);
                                  },
                                ),
                              );
                            },
                            child: Container(
                              width: 160,
                              margin: EdgeInsets.all(10),
                              child: CacheNetworkImage(
                                imageUrl: movie.posterPath,
                                fit: .cover,
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
            },
          ),
        ),
      ),
    );
  }
}
