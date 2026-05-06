import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/common/app_bar.dart';
import 'package:movie_app/core/common/custem_action_bookmark_icon%20.dart';
import 'package:movie_app/core/utils/assets_icons.dart';
import 'package:movie_app/core/widgets/cache_networkImage_widget.dart';
import 'package:movie_app/feature/details/domain/use_case/get_details_use_case.dart';
import 'package:movie_app/feature/details/domain/use_case/get_similar_use_case.dart';
import 'package:movie_app/feature/details/presentation/view/widgets/view_movie_widget.dart';
import 'package:movie_app/feature/details/presentation/view_model/details_cubit.dart';

class DetailsMovieScreen extends StatefulWidget {
  const DetailsMovieScreen({super.key, required this.id});
  static const String routeName = "DetailsMovieScreen";
  final int id;
  @override
  State<DetailsMovieScreen> createState() => _DetailsMovieScreenState();
}

class _DetailsMovieScreenState extends State<DetailsMovieScreen> {
  late DetailsCubit _cubit;
  final ScrollController _scrollController = ScrollController();
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: CustomAppBar(
        title: "Detail",
        actions: [CustomActionBookmark()],
        leading: Image.asset(AssetsIcon.back_button_icon),
      ),

      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          BlocBuilder<DetailsCubit, DetailsState>(
            bloc: _cubit,
            buildWhen: (previous, current) =>
                current is DetailsLoadingState ||
                current is DetailsSuccessState ||
                current is DetailsErrorState,
            builder: (context, state) {
              if (state is DetailsLoadingState) {
                return SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (state is DetailsSuccessState) {
                return SliverToBoxAdapter(
                  child: ViewMovieWidget(movieDetails: _cubit.movie),
                );
              }
              if (state is DetailsErrorState) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      state.error,
                      textAlign: .center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: .w400,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                  ),
                );
              }
              return SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
          SliverToBoxAdapter(child: SizedBox(height: 24)),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "similar",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: .w400,
                  color: Color(0xffFFFFFF),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 24)),
          BlocBuilder<DetailsCubit, DetailsState>(
            bloc: _cubit,
            buildWhen: (previous, current) =>
                current is SimilarLoadingState ||
                current is SimilarSuccessState ||
                current is SimilarErrorState,
            builder: (context, state) {
              if (state is SimilarLoadingState) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (state is SimilarSuccessState) {
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  sliver: SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 15.0,
                      crossAxisSpacing: 15.0,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: _cubit.similarMovies.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) {
                                return DetailsMovieScreen(
                                  id: _cubit.similarMovies[index].id,
                                );
                              },
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CacheNetworkImage(
                            imageUrl: _cubit.similarMovies[index].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              if (state is SimilarErrorState) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: Text(state.error)),
                );
              }
              return SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
        ],
      ),
    );
  }
}
