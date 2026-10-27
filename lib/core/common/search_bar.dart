
import 'package:flutter/material.dart';

import 'package:movie_app/core/utils/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onSubmitted,
    this.onChanged,
    this.onClear,
    this.hintText = 'Search movie...',
  });

  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final hasText = controller.text.isNotEmpty;

    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.search,
      style: const TextStyle(
        color: AppColor.primaryTextColor,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppColor.secondaryTextLightColor,
          fontSize: 13,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: AppColor.secondaryTextLightColor,
          size: 19,
        ),
        suffixIcon: hasText
            ? IconButton(
                tooltip: 'Clear search',
                onPressed: onClear,
                icon: const Icon(
                  Icons.close_rounded,
                  size: 17,
                  color: AppColor.secondaryTextLightColor,
                ),
              )
            : null,
        filled: true,
        fillColor: const Color(0xFF191A20),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Color(0xFF292B30),
            width: 0.7,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: AppColor.primaryDarkColor,
            width: 0.9,
          ),
        ),
      ),
    );
  }
}
