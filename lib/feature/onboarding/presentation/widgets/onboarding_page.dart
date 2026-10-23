import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/app_colors.dart';
import '../../data/onboarding_data.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key, required this.data, required this.index});

  final OnboardingData data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 11, child: _buildHeroImage()),
        const SizedBox(height: 22),
        _buildTitle(),
        const SizedBox(height: 8),
        Text(
          data.description,
          style: GoogleFonts.inter(
            fontSize: 13,
            height: 1.65,
            color: AppColor.secondaryTextLightColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroImage() {
    final isReelsPage = index == 1;

    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isReelsPage ? 28 : 24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              data.image,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColor.secondaryBackgroundColor,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.movie_outlined,
                    color: AppColor.primaryColor,
                    size: 48,
                  ),
                );
              },
            ),

            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.04),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.18),
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '${data.title}\n',
            style: GoogleFonts.playfairDisplay(
              color: AppColor.primaryTextColor,
              fontSize: 27,
              height: 1.15,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: data.highlightedTitle,
            style: GoogleFonts.playfairDisplay(
              color: AppColor.primaryColor,
              fontSize: 27,
              height: 1.15,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
