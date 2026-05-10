import 'package:flutter/material.dart';

import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/utils/assets_icons.dart';
import 'package:movie_app/core/widgets/cache_networkImage_widget.dart';

import 'package:movie_app/feature/details/presentation/view/details_movie_screen.dart';

import 'package:movie_app/feature/search/domain/entities/movie_entity.dart';

class MovieItem extends StatelessWidget {
  final MovieEntity movie;

  final String query;

  const MovieItem({super.key, required this.movie, required this.query});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,

          DetailsMovieScreen.routeName,

          arguments: movie.id,
        );
      },

      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            CacheNetworkImage(
              imageUrl: movie.image,

              width: 100,

              height: 140,

              borderRadius: BorderRadius.circular(16),
            ),

            SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  RichText(
                    maxLines: 1,

                    overflow: TextOverflow.ellipsis,

                    text: TextSpan(
                      children: highlightText(movie.title, query),

                      style: TextStyle(
                        fontSize: 24,

                        fontWeight: FontWeight.w500,

                        color: AppColor.primaryTextColor,
                      ),
                    ),
                  ),

                  SizedBox(height: 14),

                  Row(
                    children: [
                      Icon(Icons.star_border, color: Colors.orange, size: 20),

                      SizedBox(width: 6),

                      Text(
                        movie.voteAverage.toStringAsFixed(1),

                        style: TextStyle(
                          color: Colors.orange,

                          fontSize: 18,

                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  Row(
                    children: [
                      Image.asset(AssetsIcon.type_movie_icon),

                      SizedBox(width: 8),

                      Text(
                        movie.genre,

                        style: TextStyle(
                          fontSize: 18,

                          fontWeight: FontWeight.w400,

                          color: Color(0xffFFFFFF),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,

                        color: Colors.white70,

                        size: 18,
                      ),

                      SizedBox(width: 8),

                      Text(
                        movie.publishDate,

                        style: TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  Row(
                    children: [
                      Icon(
                        Icons.access_time_outlined,

                        color: Colors.white70,

                        size: 18,
                      ),

                      SizedBox(width: 8),

                      Text(
                        "139 minutes",

                        style: TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<TextSpan> highlightText(String text, String query) {
    if (query.isEmpty) {
      return [TextSpan(text: text)];
    }

    final matches = RegExp(query, caseSensitive: false);

    final spans = <TextSpan>[];

    int start = 0;

    for (final match in matches.allMatches(text)) {
      if (match.start > start) {
        spans.add(TextSpan(text: text.substring(start, match.start)));
      }

      spans.add(
        TextSpan(
          text: text.substring(match.start, match.end),

          style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
        ),
      );

      start = match.end;
    }

    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }

    return spans;
  }
}
