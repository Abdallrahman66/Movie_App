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
      children: [
        Image.asset(iconPath, color: Color(0xff92929D)),
        SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: .w500,
            color: Color(0xff92929D),
          ),
        ),
      ],
    );
  }
}
