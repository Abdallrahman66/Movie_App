
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/core/common/search_bar.dart';
import 'package:movie_app/core/dialogs/show_error_ui.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/widgets/loading_shimmer.widget.dart';

import 'package:movie_app/feature/menu_drawer/view/menu_drawer_screen .dart';
import 'package:movie_app/feature/search/data/api/home_search_api.dart';
import 'package:movie_app/feature/search/data/repo/search_repository_imp.dart';
import 'package:movie_app/feature/search/domain/use_case/search_movies_use_case.dart';
import 'package:movie_app/feature/search/presentation/view/screen/invalid_search_screen.dart';
import 'package:movie_app/feature/search/presentation/view/widget/movie_item.dart';
import 'package:movie_app/feature/search/presentation/view_model/cubit/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = 'SearchScreen';

  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(
        SearchMoviesUseCase(
          SearchRepositoryImpl(
            HomeSearchApi(),
          ),
        ),
      ),
      child: const _SearchScreenBody(),
    );
  }
}

class _SearchScreenBody extends StatefulWidget {
  const _SearchScreenBody();

  @override
  State<_SearchScreenBody> createState() => _SearchScreenBodyState();
}

class _SearchScreenBodyState extends State<_SearchScreenBody> {
  static const Duration _debounceDuration = Duration(milliseconds: 450);

  final TextEditingController controller = TextEditingController();

  Timer? debounce;

  @override
  void dispose() {
    debounce?.cancel();
    controller.dispose();
    super.dispose();
  }

  void onSearchChanged(String value) {
    debounce?.cancel();

    setState(() {});

    final query = value.trim();

    if (query.isEmpty) {
      context.read<SearchCubit>().clearSearch();
      return;
    }

    debounce = Timer(_debounceDuration, () {
      if (!mounted) return;

      context.read<SearchCubit>().searchMovies(query);
    });
  }

  void clearSearch() {
    debounce?.cancel();
    controller.clear();

    context.read<SearchCubit>().clearSearch();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      endDrawer: MenuDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              CustomSearchBar(
                controller: controller,
                onChanged: onSearchChanged,
                onSubmitted: (value) {
                  debounce?.cancel();

                  final query = value.trim();

                  if (query.isNotEmpty) {
                    context.read<SearchCubit>().searchMovies(query);
                  }
                },
                onClear: clearSearch,
              ),

              const SizedBox(height: 8),

              Expanded(
                child: BlocConsumer<SearchCubit, SearchState>(
                  listener: (context, state) {
                    if (state is SearchError) {
                      AppErrorHandler.unknown(context, state.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is SearchInitial) {
                      return const SizedBox.shrink();
                    }

                    if (state is SearchLoading) {
                      return _buildLoadingList();
                    }

                    if (state is SearchEmpty) {
                      return InvalidSearchScreen(
                        onClearSearch: clearSearch,
                      );
                    }

                    if (state is SearchError) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Text(
                            'Something went wrong.\nPlease try again.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColor.secondaryTextLightColor,
                              fontSize: 13,
                              height: 1.5,
                            ),
                          ),
                        ),
                      );
                    }

                    if (state is SearchSuccess) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4, 8, 4, 12),
                            child: Row(
                              children: [
                                const Text(
                                  'RESULTS FOR ',
                                  style: TextStyle(
                                    color: AppColor.secondaryTextLightColor,
                                    fontSize: 10,
                                    letterSpacing: 0.8,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '"${state.query}"',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: AppColor.primaryDarkColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${state.movies.length} found',
                                  style: const TextStyle(
                                    color: AppColor.secondaryTextLightColor,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              itemCount: state.movies.length,
                              separatorBuilder: (_, __) => const Divider(
                                height: 1,
                                color: Color(0xFF222329),
                              ),
                              itemBuilder: (context, index) {
                                return MovieItem(
                                  movie: state.movies[index],
                                  query: state.query,
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingList() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoadingShimmer(
                width: 82,
                height: 115,
                borderRadius: BorderRadius.circular(9),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    LoadingShimmer(
                      height: 15,
                      width: MediaQuery.sizeOf(context).width * 0.42,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    const SizedBox(height: 15),
                    LoadingShimmer(
                      height: 12,
                      width: 100,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    const SizedBox(height: 12),
                    LoadingShimmer(
                      height: 12,
                      width: 130,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    const SizedBox(height: 12),
                    LoadingShimmer(
                      height: 12,
                      width: 85,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
