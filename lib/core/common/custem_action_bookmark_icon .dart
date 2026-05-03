import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_colors.dart';

class CustomActionBookmark extends StatefulWidget {
  const CustomActionBookmark({super.key});

  @override
  State<CustomActionBookmark> createState() => _CustomActionBookmarkState();
}

class _CustomActionBookmarkState extends State<CustomActionBookmark> {
  bool isSaved = false;

  void toggleSave() {
    setState(() {
      isSaved = !isSaved;
    });
    if (isSaved) {
      log("Added to Watchlist");
    } else {
      log("Removed from Watchlist");
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: toggleSave,
      icon: Icon(
        isSaved ? Icons.bookmark : Icons.bookmark_border,
        color: AppColor.SecoundryTextColor,
      ),
    );
  }
}
