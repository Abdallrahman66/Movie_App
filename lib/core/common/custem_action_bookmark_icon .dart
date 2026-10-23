import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_colors.dart';

import '../dialogs/app_toasts.dart';

class CustomActionBookmark extends StatefulWidget {
  const CustomActionBookmark({super.key, required this.id});
  final int id;

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
      AppToast.show(
        context: context,
        title: "1",
        description: "Saved",
        type: .success,
      );
    } else {
      AppToast.show(
        context: context,
        title: "2",
        description: "unSaved",
        type: .success,
      );
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
