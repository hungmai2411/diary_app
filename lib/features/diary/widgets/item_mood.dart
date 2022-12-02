import 'package:diary_app/constants/app_assets.dart';
import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/features/diary/models/mood.dart';
import 'package:flutter/material.dart';

class ItemMood extends StatelessWidget {
  final Mood mood;
  final bool isPicked;
  final Function(Mood) callback;

  const ItemMood({
    super.key,
    required this.mood,
    required this.isPicked,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => callback(mood),
      child: Opacity(
        opacity: isPicked ? 1 : 0.3,
        child: Image.asset(
          mood.image,
          width: 70,
          height: 70,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
