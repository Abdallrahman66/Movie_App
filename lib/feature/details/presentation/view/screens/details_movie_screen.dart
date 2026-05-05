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
      appBar: CustomAppBar(
        title: "Detail",
        actions: [CustomActionBookmark()],
        leading: Image.asset(AssetsIcon.back_button_icon),
      ),
      body: Scaffold(backgroundColor: AppColor.backgroundColor),
    );
  }
}
