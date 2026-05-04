import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

///! how to use
///ex:
///AppToast.show(
///  context: context,
///   title: "Added to Watchlist",
///   description: "Movie saved successfully ",
///   type: .success,
/// );

abstract class AppToast {
  static void show({
    required BuildContext context,
    required String title,
    required String description,
    required ToastificationType type,
  }) {
    final Color mainColor = _getColor(type);
    final IconData icon = _getIcon(type);

    toastification.show(
      context: context,
      type: type,
      style: .flatColored,
      autoCloseDuration: const Duration(seconds: 2),
      alignment: .topCenter,

      title: Row(
        children: [
          Icon(icon, color: mainColor, size: 22),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: .bold,
                color: Color(0xffffffff),
              ),
            ),
          ),
        ],
      ),

      description: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Text(
          description,
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
      ),

      backgroundColor: const Color(0xFF1C1C1E),
      foregroundColor: Color(0xffffffff),
      borderRadius: .circular(16),
      borderSide: BorderSide(color: mainColor.withOpacity(0.4)),
      boxShadow: [
        BoxShadow(
          color: mainColor.withOpacity(0.2),
          blurRadius: 20,
          spreadRadius: 1,
        ),
      ],
    );
  }

  static Color _getColor(ToastificationType type) {
    switch (type) {
      case ToastificationType.success:
        return Colors.green;
      case ToastificationType.info:
        return Colors.blue;
      case ToastificationType.warning:
        return Colors.orange;
      case ToastificationType.error:
        return Colors.red;
      default:
        return Colors.white;
    }
  }

  static IconData _getIcon(ToastificationType type) {
    switch (type) {
      case ToastificationType.success:
        return Icons.check_circle;
      case ToastificationType.info:
        return Icons.movie;
      case ToastificationType.warning:
        return Icons.warning_amber;
      case ToastificationType.error:
        return Icons.error;
      default:
        return Icons.notifications;
    }
  }
}
