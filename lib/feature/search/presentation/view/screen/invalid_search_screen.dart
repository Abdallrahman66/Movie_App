import 'package:flutter/material.dart';

import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/utils/assets_image.dart';

class InvalidSearchScreen extends StatelessWidget {
  const InvalidSearchScreen({super.key, this.onClearSearch});

  final VoidCallback? onClearSearch;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AssetsImage.NoResultSearch,
                height: 140,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 24),
              const Text(
                'We Are Sorry, We Can Not\nFind The Movie',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: AppColor.primaryTextColor,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Find your movie by typing its title.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColor.secondaryTextLightColor,
                  height: 1.5,
                ),
              ),
              if (onClearSearch != null) ...[
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: onClearSearch,
                  icon: const Icon(Icons.refresh_rounded, size: 16),
                  label: const Text('Clear Search'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColor.primaryTextColor,
                    side: const BorderSide(color: Color(0xFF383A40)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    shape: const StadiumBorder(),
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
