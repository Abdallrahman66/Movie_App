
import 'package:flutter/material.dart';
import 'package:movie_app/core/widgets/cache_networkImage_widget.dart';
import 'package:movie_app/feature/details/domain/entities/details_entity.dart';

class CastCrewItem extends StatelessWidget {
  const CastCrewItem({
    super.key,
    required this.credit,
  });

  final MovieCreditEntity credit;

  static const Color _muted = Color(0xFF92929D);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 76,
      child: Column(
        children: [
          ClipOval(
            child: SizedBox(
              width: 62,
              height: 62,
              child: _buildProfileImage(),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            credit.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            credit.role,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _muted,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    if (credit.profileImage.isEmpty) {
      return Container(
        color: const Color(0xFF242A32),
        alignment: Alignment.center,
        child: const Icon(
          Icons.person,
          color: _muted,
          size: 30,
        ),
      );
    }

    return CacheNetworkImage(
      imageUrl: credit.profileImage,
      fit: BoxFit.cover,
    );
  }
}
