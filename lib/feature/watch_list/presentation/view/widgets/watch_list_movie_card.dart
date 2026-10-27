import 'package:flutter/material.dart';

import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/widgets/cache_networkImage_widget.dart';

import '../../../data/models/watch_list_movie_model.dart';

class WatchListMovieCard extends StatelessWidget {
  const WatchListMovieCard({
    super.key,
    required this.movie,
    required this.onRemove,
    required this.onTap,
  });

  final WatchListMovieModel movie;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(15),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 164,
          decoration: BoxDecoration(
            color: AppColor.watchListCard.withValues(alpha: 0.96),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColor.watchListBorder, width: 0.8),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CacheNetworkImage(
                    imageUrl: movie.posterPath,
                    width: 95,
                    height: 144,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(7, 15, 0, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              movie.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColor.watchListTitle,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                height: 1.25,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),

                          IconButton(
                            onPressed: onRemove,
                            tooltip: 'Remove from Watch List',
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 25,
                              minHeight: 25,
                            ),
                            icon: const Icon(
                              Icons.bookmark_rounded,
                              color: AppColor.watchListGold,
                              size: 21,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 13),

                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: AppColor.watchListGold,
                            size: 17,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            movie.voteAverage.toStringAsFixed(2),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 9),

                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              _formatReleaseDate(movie.releaseDate),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColor.watchListMuted,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.swipe_left_rounded,
                            color: AppColor.watchListMuted.withValues(
                              alpha: 0.8,
                            ),
                            size: 15,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Swipe left to remove',
                            style: TextStyle(
                              color: AppColor.watchListMuted.withValues(
                                alpha: 0.8,
                              ),
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _formatReleaseDate(String date) {
  if (date.isEmpty) return 'Release date unavailable';

  if (date.length >= 4) return date.substring(0, 4);

  return date;
}
