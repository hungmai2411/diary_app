import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/features/board/widgets/item_mood_percent.dart';
import 'package:diary_app/features/board/widgets/item_mood_percent_detail.dart';
import 'package:diary_app/features/diary/models/diary.dart';
import 'package:flutter/material.dart';

class MoodBar extends StatelessWidget {
  final List<Diary> diariesMonth;

  const MoodBar({
    super.key,
    required this.diariesMonth,
  });

  @override
  Widget build(BuildContext context) {
    List<int> percents = getListPercent();
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
                  flex: percents[0],
                  color: AppColors.mood1,
                  radius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                // Mood 4
                ItemMoodPercent(
                  flex: percents[1],
                  color: AppColors.mood2,
                ),
                // Mood 3
                ItemMoodPercent(
                  flex: percents[2],
                  color: AppColors.mood3,
                ),
                // Mood 2
                ItemMoodPercent(
                  flex: percents[3],
                  color: AppColors.mood4,
                ),
                // Mood 1
                ItemMoodPercent(
                  flex: percents[4],
                  color: AppColors.mood5,
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
                percent: percents[0],
              ),
              ItemMoodPercentDetail(
                color: AppColors.mood4,
                percent: percents[1],
              ),
              ItemMoodPercentDetail(
                color: AppColors.mood3,
                percent: percents[2],
              ),
              ItemMoodPercentDetail(
                color: AppColors.mood2,
                percent: percents[3],
              ),
              ItemMoodPercentDetail(
                color: AppColors.mood1,
                percent: percents[4],
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<int> getListPercent() {
    int mood1 = 0;
    int mood2 = 0;
    int mood3 = 0;
    int mood4 = 0;
    int mood5 = 0;
    int totalMood = diariesMonth.length;

    for (Diary diary in diariesMonth) {
      double index = diary.mood.getIndex();

      if (index == 1) {
        mood5++;
      } else if (index == 2) {
        mood4++;
      } else if (index == 3) {
        mood3++;
      } else if (index == 4) {
        mood2++;
      } else if (index == 5) {
        mood1++;
      }
    }

    int mood1Percent = ((mood1 / totalMood) * 100).round();
    int mood2Percent = ((mood2 / totalMood) * 100).round();
    int mood3Percent = ((mood3 / totalMood) * 100).round();
    int mood4Percent = ((mood4 / totalMood) * 100).round();
    int mood5Percent = ((mood5 / totalMood) * 100).round();

    List<int> percents = [
      mood1Percent,
      mood2Percent,
      mood3Percent,
      mood4Percent,
      mood5Percent
    ];

    return percents;
  }
}
