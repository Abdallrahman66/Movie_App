import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  CustomSearchBar({
    super.key,
    this.hintText = "Search movie...",
    required this.controller,
    required this.onSubmitted,
    this.onChanged,
  });
  final TextEditingController controller;
  void Function(String)? onSubmitted;
  final String hintText;
  void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),

          filled: true,
          fillColor: const Color(0xFF2A2A2A),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
