import 'package:flutter/material.dart';

import 'package:movie_app/core/utils/app_colors.dart';

class CustemActionMenu extends StatelessWidget {
  const CustemActionMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return IconButton(
          icon: Icon(Icons.menu_outlined, color: AppColor.SecoundryTextColor),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      },
    );
  }
}
