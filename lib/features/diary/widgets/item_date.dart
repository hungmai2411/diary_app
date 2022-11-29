import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ItemDate extends StatelessWidget {
  final String date;
  final Color color;
  final String? img;
  bool? isSelected;

  ItemDate({
    super.key,
    required this.date,
    this.img,
    this.color = Colors.black,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          Text(
            date,
            style: isSelected!
                ? AppStyles.semibold.copyWith(
                    color: color,
                    fontSize: 14,
                  )
                : AppStyles.medium.copyWith(
                    color: color,
                    fontSize: 14,
                  ),
          ),
          const SizedBox(height: 2),
          img != null
              ? Image.asset(
                  img!,
                  fit: BoxFit.fitHeight,
                  width: 45,
                  height: 37,
                )
              : Container(
                  width: 45,
                  height: 37,
                  decoration: BoxDecoration(
                    color: AppColors.unNote,
                    shape: BoxShape.circle,
                  ),
                ),
        ],
      ),
    );
  }
}
