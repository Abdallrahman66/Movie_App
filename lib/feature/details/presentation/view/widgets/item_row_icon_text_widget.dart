
import 'package:flutter/material.dart';

class IteamRowIconTextWidget extends StatelessWidget {
  const IteamRowIconTextWidget({
    super.key,
    required this.iconPath,
    required this.text,
  });

  final String iconPath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          iconPath,
          width: 15,
          height: 15,
          color: const Color(0xFF92929D),
        ),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF92929D),
            ),
          ),
        ),
      ],
    );
  }
}
