import 'package:flutter/material.dart';

import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/utils/assets_image.dart';

class InvalidSearchScreen extends StatelessWidget {
  static const String routeName = "InvalidSearchScreen";

  const InvalidSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset(AssetsImage.NoResultSearch, height: 140),

            SizedBox(height: 30),

            Text(
              "We Are Sorry, We Can\nNot Find The Movie :(",

              textAlign: TextAlign.center,

              style: TextStyle(
                fontSize: 18,

                fontWeight: FontWeight.w600,

                color: AppColor.primaryTextColor,

                height: 1.4,
              ),
            ),

            SizedBox(height: 12),

            Text(
              "Find your movie by Type title,\ncategories, years, etc",

              textAlign: TextAlign.center,

              style: TextStyle(
                fontSize: 14,

                color: AppColor.SecoundryTextColor,

                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
