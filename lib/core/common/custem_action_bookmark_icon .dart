import 'package:flutter/material.dart';
import 'package:movie_app/core/di/service_locatore.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/feature/watch_list/presentation/view_model/watch_list_cubit.dart';
import 'package:movie_app/feature/details/domain/entities/details_entity.dart';
import 'package:movie_app/feature/details/domain/use_case/get_details_use_case.dart';
import 'package:movie_app/feature/watch_list/data/models/watch_list_movie_model.dart';
import 'package:movie_app/feature/watch_list/domain/use_cases/get_watch_list_use_case.dart';

import '../dialogs/app_toasts.dart';

class CustomActionBookmark extends StatefulWidget {
  const CustomActionBookmark({super.key, required this.id});

  final int id;

  @override
  State<CustomActionBookmark> createState() => _CustomActionBookmarkState();
}

class _CustomActionBookmarkState extends State<CustomActionBookmark> {
  bool isSaved = false;
  bool isLoading = true;
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    _loadSavedStatus();
  }

  Future<void> _loadSavedStatus() async {
    try {
      final movies = await getIt<GetWatchListUseCase>()();

      if (!mounted) return;

      setState(() {
        isSaved = movies.any((movie) => movie.id == widget.id);
        isLoading = false;
      });
    } catch (error, stackTrace) {
      debugPrint('Load bookmark status error: $error');
      debugPrintStack(stackTrace: stackTrace);

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _toggleSave() async {
    if (isLoading || isProcessing) return;

    setState(() {
      isProcessing = true;
    });

    try {
      final movies = await getIt<GetWatchListUseCase>()();

      final savedMovies = movies.where((movie) => movie.id == widget.id);

      if (savedMovies.isNotEmpty) {
        await getIt<WatchListCubit>().toggleMovie(savedMovies.first);

        if (!mounted) return;

        setState(() {
          isSaved = false;
        });

        AppToast.show(
          context: context,
          title: 'Watch List',
          description: 'Movie removed from Watch List',
          type: .success,
        );

        return;
      }

      final result = await getDetailsUseCaseInject().invoke(widget.id);

      if (!mounted) return;

      if (result is ErrorApi<DetailsEntity>) {
        AppToast.show(
          context: context,
          title: 'Error',
          description: result.errorMassage,
          type: .success,
        );

        return;
      }

      if (result is SuccessApi<DetailsEntity>) {
        final movie = result.data;

        final watchListMovie = WatchListMovieModel(
          id: widget.id,
          title: movie.title,
          posterPath: movie.image,
          voteAverage: movie.voteAverage,
          releaseDate: movie.publishDate,
          overview: movie.description,
        );

        await getIt<WatchListCubit>().toggleMovie(watchListMovie);

        if (!mounted) return;

        setState(() {
          isSaved = true;
        });

        AppToast.show(
          context: context,
          title: 'Watch List',
          description: 'Movie added to Watch List',
          type: .success,
        );
      }
    } catch (error, stackTrace) {
      debugPrint('Toggle bookmark error: $error');
      debugPrintStack(stackTrace: stackTrace);

      if (!mounted) return;

      AppToast.show(
        context: context,
        title: 'Error',
        description: 'Could not update Watch List.',
        type: .success,
      );
    } finally {
      if (mounted) {
        setState(() {
          isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isLoading || isProcessing ? null : _toggleSave,
      tooltip: isSaved ? 'Remove from Watch List' : 'Add to Watch List',
      icon: isLoading || isProcessing
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xFFC9A96E),
              ),
            )
          : Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: isSaved
                  ? const Color(0xFFC9A96E)
                  : AppColor.SecoundryTextColor,
            ),
    );
  }
}
