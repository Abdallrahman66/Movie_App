import 'package:flutter/material.dart';

import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/common/app_bar.dart';
import 'package:movie_app/core/common/custem_action_bookmark_icon%20.dart';
import 'package:movie_app/core/utils/assets_icons.dart';

class DetailsMovieScreen extends StatelessWidget {
  const DetailsMovieScreen({super.key});
  static const String routeName = "DetailsMovieScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: CustomAppBar(
        title: "Detail",
        actions: [CustomActionBookmark()],
        leading: Image.asset(AssetsIcon.back_button_icon),
      ),
      body: Column(
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
                    image: AssetImage("assets/images/cover.png"),
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
                      Icon(
                        Icons.star_border,
                        color: Color(0xffFF8700),
                        size: 18,
                      ),
                      Text(" 9.5", style: TextStyle(color: Color(0xffFF8700))),
                    ],
                  ),
                ),
              ),

              Positioned(
                left: 30,
                top: 170,
                child: Row(
                  crossAxisAlignment: .end,

                  children: [
                    Image.asset(
                      "assets/images/image.png",
                      height: 120,
                      width: 95,
                    ),
                    Text(
                      "Spiderman No Way Home",
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
        ],
      ),
    );
  }
}
