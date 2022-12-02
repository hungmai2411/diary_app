import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/features/diary/models/diary.dart';
import 'package:diary_app/widgets/box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemDiary extends StatelessWidget {
  final Diary diary;

  const ItemDiary({
    super.key,
    required this.diary,
  });

  @override
  Widget build(BuildContext context) {
    return Box(
      child: IntrinsicHeight(
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  diary.createdAt.day.toString(),
                  style: AppStyles.regular.copyWith(
                    fontSize: 25,
                  ),
                ),
                Text(
                  DateFormat("MMM").format(diary.createdAt),
                  style: AppStyles.regular.copyWith(
                    fontSize: 14,
                  ),
                ),
                Image.asset(
                  diary.mood.image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const SizedBox(width: 10),
            const VerticalDivider(
              color: AppColors.textSecondaryColor,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    diary.content ?? 'Nothing is written for this day 🙁',
                    style: AppStyles.regular.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  if (diary.images != null)
                    Wrap(
                      children: diary.images!
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                                right: 8.0,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.memory(
                                  e,
                                  fit: BoxFit.cover,
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
