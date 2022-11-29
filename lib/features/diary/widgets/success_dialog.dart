import 'package:diary_app/constants/app_assets.dart';
import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        // width: 200,
        // height: 200,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              'The diary has been recorded',
              style: AppStyles.medium.copyWith(),
            ),
            const SizedBox(height: 15),
            Image.asset(
              AppAssets.imgGold,
              fit: BoxFit.cover,
            ),
            Text(
              '100 coin',
              style: AppStyles.bold.copyWith(
                color: AppColors.orange,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.selectedColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Claim',
                  style: AppStyles.regular.copyWith(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
