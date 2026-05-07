import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/core/common/app_bar.dart';
import 'package:movie_app/core/common/search_bar.dart';
import 'package:movie_app/core/dialogs/show_error_ui.dart';
import 'package:movie_app/core/utils/app_colors.dart';

import 'package:movie_app/feature/menu_drawer/view/menu_drawer_screen .dart';

import 'package:movie_app/feature/search/data/api/home_search_api.dart';
import 'package:movie_app/feature/search/data/repo/search_repository_imp.dart';

import 'package:movie_app/feature/search/domain/use_case/search_movies_use_case.dart';

import 'package:movie_app/feature/search/presentation/view/screen/invalid_search_screen.dart';
import 'package:movie_app/feature/search/presentation/view/widget/movie_item.dart';

import '../../view_model/cubit/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = "SearchScreen";

  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(
        SearchMoviesUseCase(SearchRepositoryImpl(HomeSearchApi())),
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
  final TextEditingController controller = TextEditingController();

  Timer? debounce;

  @override
  void dispose() {
    debounce?.cancel();
    controller.dispose();

    super.dispose();
  }

  void onSearchChanged(String value) {
    if (debounce?.isActive ?? false) {
      debounce!.cancel();
    }

    debounce = Timer(const Duration(milliseconds: 500), () {
      if (value.trim().isNotEmpty) {
        context.read<SearchCubit>().searchMovies(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,

      endDrawer: MenuDrawer(),

      appBar: CustomAppBar(title: "Search"),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            CustomSearchBar(
              controller: controller,

              onSubmitted: (value) {},

              onChanged: onSearchChanged,
            ),

            const SizedBox(height: 10),

            Expanded(
              child: BlocConsumer<SearchCubit, SearchState>(
                listener: (context, state) {
                  if (state is SearchError) {
                    AppErrorHandler.unknown(context, state.error);
                  }
                },

                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is SearchEmpty) {
                    return const InvalidSearchScreen();
                  }

                  if (state is SearchError) {
                    return const InvalidSearchScreen();
                  }

                  if (state is SearchSuccess) {
                    return ListView.builder(
                      itemCount: state.movies.length,

                      itemBuilder: (context, index) {
                        return MovieItem(movie: state.movies[index]);
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
