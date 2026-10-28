import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:movie_app/app_section/app_section_view.dart';
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
  static const Color _gold = Color(0xFFC9A96E);
  static const Color _teal = Color(0xFF6BB8B8);
  static const Color _cardColor = Color(0xFF24262B);

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
        appBar: CustomAppBar(title: 'Watch List '),

        body: BlocBuilder<WatchListCubit, WatchListState>(
          builder: (context, state) {
            if (state is WatchListInitial || state is WatchListLoading) {
              return const Center(
                child: CircularProgressIndicator(color: _gold),
              );
            }

            if (state is WatchListError) {
              return _buildErrorState(state.message);
            }

            if (state is WatchListLoaded) {
              if (state.movies.isEmpty) {
                return _buildEmptyState(context);
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
                    onDismissed: (_) => _removeMovie(movie.id),
                    child: WatchListMovieCard(
                      movie: movie,
                      onRemove: () => _removeMovie(movie.id),
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

  Future<void> _removeMovie(int movieId) async {
    try {
      await _watchListCubit.removeMovie(movieId);
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not remove this movie. Please try again.'),
        ),
      );

      await _watchListCubit.loadMovies();
    }
  }

  Widget _buildEmptyState(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  Image.asset(
                    'assets/images/watchlist_empty.png',
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) {
                      return const Icon(
                        Icons.movie_creation_outlined,
                        size: 100,
                        color: _gold,
                      );
                    },
                  ),
                  const SizedBox(height: 34),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 24,
                        height: 1,
                        color: _gold.withValues(alpha: 0.7),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          'YOUR PERSONAL COLLECTION',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.manrope(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                            color: _gold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 24,
                        height: 1,
                        color: _gold.withValues(alpha: 0.7),
                      ),
                    ],
                  ),
                  const SizedBox(height: 17),
                  Text(
                    'Your Next Favorite\nStarts Here.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cinzel(
                      fontSize: 29,
                      height: 1.3,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFF0E9E0),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Every great movie deserves a place.\n'
                    'Discover stories worth watching and\n'
                    'build a collection that feels like yours.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      height: 1.9,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFB6B2AD),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 300,
                    height: 58,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: _cardColor,
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: _gold.withValues(alpha: 0.08),
                            blurRadius: 25,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(32),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(32),
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppSectionView.routeName,
                              (route) => false,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.movie_filter_outlined,
                                  size: 23,
                                  color: _gold,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Explore Movies',
                                  style: GoogleFonts.manrope(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.7,
                                    color: const Color(0xFFF0E2C7),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Icon(
                                  Icons.arrow_forward_rounded,
                                  color: _teal,
                                  size: 23,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'A WORLD OF STORIES AWAITS',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                      color: AppColor.SecoundryTextColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: Colors.redAccent,
              size: 42,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                color: AppColor.primaryTextColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _watchListCubit.loadMovies,
              style: ElevatedButton.styleFrom(
                backgroundColor: _gold,
                foregroundColor: Colors.black,
              ),
              child: Text(
                'Try Again',
                style: GoogleFonts.manrope(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
