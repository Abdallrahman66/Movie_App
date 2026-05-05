import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/assets_icons.dart';
import 'package:movie_app/core/widgets/cache_networkImage_widget.dart';
import 'package:movie_app/feature/details/domain/entities/details_entity.dart';
import 'package:movie_app/feature/details/presentation/view/widgets/item_row_icon_text_widget.dart';

class ViewMovieWidget extends StatelessWidget {
  const ViewMovieWidget({super.key, required this.movieDetails});
  final DetailsEntity movieDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(movieDetails.coverImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star_border, color: Color(0xffFF8700), size: 18),
                    Text(
                      movieDetails.voteAverage.roundToDouble().toString(),
                      style: TextStyle(color: Color(0xffFF8700)),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              left: 30,
              top: 175,
              child: Row(
                crossAxisAlignment: .end,

                children: [
                  CacheNetworkImage(
                    imageUrl: movieDetails.image,
                    height: 140,
                    width: 100,
                    fit: BoxFit.fill,
                  ),
                  Text(
                    movieDetails.title,
                    textAlign: .left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: .w600,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 80),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Row(
            children: [
              IteamRowIconTextWidget(
                iconPath: AssetsIcon.calendar_blank_icon,
                text: movieDetails.publishDate,
              ),
              SizedBox(
                height: 20,
                child: VerticalDivider(
                  color: Color(0xff92929D),
                  thickness: 1,
                  width: 40,
                ),
              ),

              IteamRowIconTextWidget(
                iconPath: AssetsIcon.clock_icon,
                text: movieDetails.timeOfMovie,
              ),
              SizedBox(
                height: 20,
                child: VerticalDivider(
                  color: Color(0xff92929D),
                  thickness: 1,
                  width: 40,
                ),
              ),

              IteamRowIconTextWidget(
                iconPath: AssetsIcon.type_movie_icon,
                text: movieDetails.category,
              ),
            ],
          ),
        ),
        // SizedBox(height: ,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          child: Text(
            movieDetails.description,
            style: TextStyle(
              fontSize: 12,
              fontWeight: .w400,
              color: Color(0xffFFFFFF),
            ),
          ),
        ),
      ],
    );
  }
}
