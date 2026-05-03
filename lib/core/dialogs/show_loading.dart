

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie_app/core/utils/app_colors.dart';

abstract class AppLoading {
  static void show(BuildContext context, {String? text}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.6), 
      builder: (_) {
        return Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1E), 
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LoadingAnimationWidget.staggeredDotsWave(
                  color: AppColor.barColor,
                  size: 50,
                ),
                const SizedBox(height: 16),
                Text(
                  text ?? "Loading...",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}
//! dynamic title
//"Loading Top Rated Movies..."
// "Adding to Watchlist..."
// "Searching..."
//! note for how to use
// AppLoading.show(context);
// await api.getMovies(); //? api
// AppLoading.hide(context);
//! how to use in search
// AppLoading.show(context, text: "Searching for \"$query\"...");
