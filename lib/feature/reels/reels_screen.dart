import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';

class ReleasesScreen extends StatelessWidget {
  const ReleasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Center(
        child: Text(
          'Coming Soon',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
