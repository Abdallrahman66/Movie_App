import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/core/common/app_bar.dart';
import 'package:movie_app/core/common/search_bar.dart';
import 'package:movie_app/core/dialogs/show_error_ui.dart';
import 'package:movie_app/core/dialogs/show_loading.dart';

import 'package:movie_app/core/utils/app_colors.dart';

import 'package:movie_app/feature/menu_drawer/view/menu_drawer_screen .dart';
import 'package:movie_app/feature/search/presentation/view/screen/invalid_search_screen.dart';
import '../widget/movie_item.dart';

import '../../view_model/cubit/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = "SearchScreen";

  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,

      endDrawer: MenuDrawer(),

      appBar: CustomAppBar(title: "Search"),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          children: [
            CustomSearchBar(
              controller: controller,

              onSubmitted: (value) {
                context.read<SearchCubit>().searchMovies(value);
              },
            ),

            SizedBox(height: 10),

            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      AppLoading.show(context, text: "Searching...");
                    });
                  } else {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      AppLoading.hide(context);
                    });
                  }

                  if (state is SearchError) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      AppErrorHandler.unknown(context, state.error);
                    });

                    return InvalidSearchWidget();
                  }

                  if (state is SearchSuccess) {
                    return ListView.builder(
                      itemCount: state.movies.length,

                      itemBuilder: (context, index) {
                        return MovieItem(movie: state.movies[index]);
                      },
                    );
                  }

                  return SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
