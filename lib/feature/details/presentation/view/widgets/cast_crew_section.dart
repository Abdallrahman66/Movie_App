
import 'package:flutter/material.dart';
import 'package:movie_app/feature/details/domain/entities/details_entity.dart';
import 'package:movie_app/feature/details/presentation/view/widgets/cast_crew_item.dart';

class CastCrewSection extends StatelessWidget {
  const CastCrewSection({
    super.key,
    required this.title,
    required this.credits,
  });

  final String title;
  final List<MovieCreditEntity> credits;

  static const Color _muted = Color(0xFF92929D);

  @override
  Widget build(BuildContext context) {
    if (credits.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              Text(
                '${credits.length} credits',
                style: const TextStyle(
                  color: _muted,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 142,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: credits.length,
            separatorBuilder: (_, index) =>
                const SizedBox(width: 14),
            itemBuilder: (context, index) {
              return CastCrewItem(
                credit: credits[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
