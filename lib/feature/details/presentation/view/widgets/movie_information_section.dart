import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/assets_icons.dart';
import 'package:movie_app/feature/details/domain/entities/details_entity.dart';
import 'package:movie_app/feature/details/presentation/view/widgets/item_row_icon_text_widget.dart';

class MovieInformationSection extends StatelessWidget {
  const MovieInformationSection({super.key, required this.movie});

  final DetailsEntity movie;

  @override
  Widget build(BuildContext context) {
    final informationItems = <Widget>[
      if (movie.publishDate.trim().isNotEmpty)
        IteamRowIconTextWidget(
          iconPath: AssetsIcon.calendar_blank_icon,
          text: movie.publishDate,
        ),

      if (movie.timeOfMovie.trim().isNotEmpty)
        IteamRowIconTextWidget(
          iconPath: AssetsIcon.clock_icon,
          text: movie.timeOfMovie,
        ),

      if (movie.categories.isNotEmpty &&
          movie.categories.first.trim().isNotEmpty)
        IteamRowIconTextWidget(
          iconPath: AssetsIcon.type_movie_icon,
          text: movie.categories.first,
        ),
    ];

    if (informationItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int index = 0; index < informationItems.length; index++) ...[
          if (index > 0) const SizedBox(height: 10),
          informationItems[index],
        ],
      ],
    );
  }
}
