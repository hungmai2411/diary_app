import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/features/diary/models/diary.dart';
import 'package:diary_app/providers/diary_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteDialog extends StatelessWidget {
  final Diary diary;

  const DeleteDialog({
    super.key,
    required this.diary,
  });

  void deleteDiary(BuildContext context) {
    context.read<DiaryProvider>().deleteDiary(diary);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      backgroundColor: AppColors.boxColor,
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to\ndelete this diary?',
              style: AppStyles.medium.copyWith(),
            ),
            const SizedBox(height: 20),
            Text(
              'This action cannot be undone',
              style: AppStyles.medium.copyWith(
                color: AppColors.deleteColor,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => deleteDiary(context),
                  child: Text(
                    'Delete',
                    style: AppStyles.regular.copyWith(
                      fontSize: 16,
                      color: AppColors.deleteColor,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.selectedColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Back',
                      style: AppStyles.regular.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
