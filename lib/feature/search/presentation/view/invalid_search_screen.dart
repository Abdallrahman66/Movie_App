import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:movie_app/feature/menu_drawer/view/menu_drawer_screen%20.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/utils/assets_image.dart';
import 'package:movie_app/core/common/app_bar.dart';

import 'package:movie_app/core/common/search_bar.dart';

class InvalidSearchScreen extends StatefulWidget {
  static const String routeName = "InvalidSearchScreen";

  const InvalidSearchScreen({super.key});

  @override
  State<InvalidSearchScreen> createState() => _InvalidSearchScreenState();
}

class _InvalidSearchScreenState extends State<InvalidSearchScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      endDrawer: MenuDrawer(),
      appBar: CustomAppBar(title: "Search"),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            CustomSearchBar(
              hintText: "Search Movie...",
              controller: controller,
              onSubmitted: (value) {
                search(); //
              },
            ),
            SizedBox(height: 200),
            Image.asset(AssetsImage.NoResultSearch),
            SizedBox(height: 30),
            Text(
              "we are sorry, we can  not find the movie ",
              style: TextStyle(
                fontSize: 20,
                fontWeight: .w600,
                color: AppColor.primaryTextColor,
              ),
            ),
            Text(
              "Find your movie by Type title, categories, years, etc  ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: .w500,
                color: AppColor.SecoundryTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void search() {
    String query = controller.text;
    log(query);

    //  call API
  }
}
