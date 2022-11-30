import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/features/board/widgets/item_mood_percent.dart';
import 'package:diary_app/features/board/widgets/item_mood_percent_detail.dart';
import 'package:flutter/material.dart';

class MoodBar extends StatelessWidget {
  const MoodBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Mood Bar',
            style: AppStyles.medium,
          ),
          const SizedBox(height: 20),
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: AppColors.orange,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                // Mood 5
                ItemMoodPercent(
                  flex: (22 / 10).round(),
                  color: AppColors.mood5,
                  radius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                // Mood 4
                ItemMoodPercent(
                  flex: (11 / 10).round(),
                  color: AppColors.mood4,
                ),
                // Mood 3
                ItemMoodPercent(
                  flex: (33 / 10).round(),
                  color: AppColors.mood3,
                ),
                // Mood 2
                ItemMoodPercent(
                  flex: (0 / 10).round(),
                  color: AppColors.mood2,
                ),
                // Mood 1
                ItemMoodPercent(
                  flex: (33 / 10).round(),
                  color: AppColors.mood1,
                  radius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ItemMoodPercentDetail(
                color: AppColors.mood5,
                percent: 22,
              ),
              ItemMoodPercentDetail(
                color: AppColors.mood4,
                percent: 11,
              ),
              ItemMoodPercentDetail(
                color: AppColors.mood3,
                percent: 33,
              ),
              ItemMoodPercentDetail(
                color: AppColors.mood2,
                percent: 0,
              ),
              ItemMoodPercentDetail(
                color: AppColors.mood1,
                percent: 33,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
