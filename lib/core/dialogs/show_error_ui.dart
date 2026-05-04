import 'package:flutter/material.dart';

abstract class AppErrorHandler {
  static void show({
    required BuildContext context,
    required String message,
    required String title ,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1C1C1E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            message,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  //! Network error
  static void network(BuildContext context) {
    show(
      context: context,
      title: "Network Error",
      message: "Please check your internet connection.",
    );
  }

  //! Server error
  static void server(BuildContext context) {
    show(
      context: context,
      title: "Server Error",
      message: "Something went wrong on our side. Try again later.",
    );
  }

 //! Unknown error
  static void unknown(BuildContext context, String error) {
    show(context: context, title: "Unexpected Error", message: error);
  }
}
