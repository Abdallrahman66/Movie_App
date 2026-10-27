import 'package:flutter/material.dart';

import 'package:movie_app/core/common/custem_action_bookmark_icon%20.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/widgets/cache_networkImage_widget.dart';
import 'package:movie_app/feature/details/presentation/view/screens/details_movie_screen.dart';
import 'package:movie_app/feature/search/domain/entities/movie_entity.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({super.key, required this.movie, required this.query});

  final MovieEntity movie;
  final String query;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final posterWidth = (screenWidth * 0.25).clamp(76.0, 100.0);
    final posterHeight = posterWidth * 1.4;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1C21).withOpacity(0.88),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColor.primaryDarkColor.withOpacity(0.16),
          width: 0.8,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailsMovieScreen(id: movie.id),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(11),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CacheNetworkImage(
                  imageUrl: movie.image,
                  width: posterWidth,
                  height: posterHeight,
                  borderRadius: BorderRadius.circular(9),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 2),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: RichText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                style: const TextStyle(
                                  color: AppColor.primaryTextColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3,
                                ),
                                children: _highlightText(movie.title, query),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),

                          CustomActionBookmark(
                            key: ValueKey('bookmark_${movie.id}'),
                            id: movie.id,
                          ),
                        ],
                      ),

                      const SizedBox(height: 11),

                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: AppColor.primaryDarkColor,
                            size: 17,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            movie.voteAverage.toStringAsFixed(1),
                            style: const TextStyle(
                              color: AppColor.primaryDarkColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '•',
                            style: TextStyle(
                              color: AppColor.secondaryTextLightColor,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              movie.genre,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColor.secondaryTextLightColor,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 9),

                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 13,
                            color: AppColor.secondaryTextLightColor,
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              movie.publishDate,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColor.secondaryTextLightColor,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),

                      if (movie.overview.isNotEmpty &&
                          movie.overview != 'No Description') ...[
                        const SizedBox(height: 9),
                        Text(
                          movie.overview,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF92939B),
                            fontSize: 10,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<TextSpan> _highlightText(String text, String searchQuery) {
    if (searchQuery.trim().isEmpty) {
      return [TextSpan(text: text)];
    }

    final normalizedText = text.toLowerCase();
    final normalizedQuery = searchQuery.trim().toLowerCase();

    final spans = <TextSpan>[];
    var currentIndex = 0;

    while (currentIndex < text.length) {
      final matchIndex = normalizedText.indexOf(normalizedQuery, currentIndex);

      if (matchIndex == -1) {
        spans.add(TextSpan(text: text.substring(currentIndex)));
        break;
      }

      if (matchIndex > currentIndex) {
        spans.add(TextSpan(text: text.substring(currentIndex, matchIndex)));
      }

      final matchEnd = matchIndex + normalizedQuery.length;

      spans.add(
        TextSpan(
          text: text.substring(matchIndex, matchEnd),
          style: const TextStyle(
            color: AppColor.primaryDarkColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      );

      currentIndex = matchEnd;
    }

    return spans;
  }
}
