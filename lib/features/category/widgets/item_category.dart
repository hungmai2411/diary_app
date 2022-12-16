import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/features/category/models/category.dart';
import 'package:flutter/material.dart';

class ItemCategory extends StatelessWidget {
  final Category category;

  const ItemCategory({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.boxColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Center(
        child: Text(
          category.title,
          textAlign: TextAlign.center,
          style: AppStyles.medium.copyWith(
            color: AppColors.textPrimaryColor,
          ),
        ),
      ),
    );
  }
}
