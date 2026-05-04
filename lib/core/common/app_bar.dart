import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
  });
  final String title;
  final List<Widget>? actions;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.barColor,
      leading: leading,
      title: Text(
        title,
        style: TextStyle(color: AppColor.primaryTextColor, fontSize: 20),
      ),
      actions: actions,

      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
