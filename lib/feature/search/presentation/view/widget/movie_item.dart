import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/widgets/cache_networkImage_widget.dart';

import 'package:movie_app/feature/search/domain/entities/movie_entity.dart';

class MovieItem extends StatelessWidget {
  final MovieEntity movie;

  const MovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),

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
                Text(
                  movie.title,

                  maxLines: 2,

                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(
                    color: AppColor.primaryTextColor,

                    fontSize: 18,

                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 12),

                Row(
                  children: [
                    Icon(Icons.star_border, color: Colors.orange, size: 20),

                    SizedBox(width: 4),

                    Text(
                      movie.voteAverage.toStringAsFixed(1),

                      style: TextStyle(
                        color: Colors.orange,

                        fontSize: 15,

                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.grey, size: 16),

                    SizedBox(width: 6),

                    Text(
                      movie.publishDate,

                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                Text(
                  movie.overview,

                  maxLines: 3,

                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
