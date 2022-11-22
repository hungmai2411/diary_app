import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/features/diary/models/mood.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
      child: SizedBox(
        width: 75,
        height: 75,
        child: Column(
          children: [
            Opacity(
              opacity: isPicked ? 1 : 0.3,
              child: Image.asset(
                mood.image,
                fit: BoxFit.cover,
                height: 45,
                width: 45,
              ),
            ),
            Text(
              mood.name,
              style: AppStyles.medium.copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
