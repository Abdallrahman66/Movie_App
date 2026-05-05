import 'package:flutter/material.dart';

import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/common/app_bar.dart';
import 'package:movie_app/core/common/custem_action_bookmark_icon%20.dart';
import 'package:movie_app/core/utils/assets_icons.dart';
import 'package:movie_app/feature/details/presentation/view/widgets/view_movie_widget.dart';

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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: ViewMovieWidget()),
          SliverToBoxAdapter(child: SizedBox(height: 24)),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "similar",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: .w400,
                  color: Color(0xffFFFFFF),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 24)),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            sliver: SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 15.0,
                childAspectRatio: 0.7,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    "assets/images/Movie _2.png",
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// SliverFillRemaining(
//             hasScrollBody: false,
//             child: Center(child: CircularProgressIndicator()),
//           );
