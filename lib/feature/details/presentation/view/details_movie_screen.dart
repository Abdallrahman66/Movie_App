import 'package:flutter/material.dart';

import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/common/app_bar.dart';
import 'package:movie_app/core/common/custem_action_bookmark_icon%20.dart';

class DetailsMovieScreen extends StatelessWidget {
  static const String routeName = "DetailsMovieScreen";
  const DetailsMovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Detail", actions: [CustomActionBookmark()]),
      body: Scaffold(backgroundColor: AppColor.backgroundColor),
    );
  }
}
