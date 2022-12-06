import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/widgets/box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ItemNoDiary extends StatelessWidget {
  const ItemNoDiary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Box(
      margin: const EdgeInsets.only(
        left: 20.0,
        right: 20,
        bottom: 10,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.moodBarEmptyPrimary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 50,
                  height: 15,
                  decoration: BoxDecoration(
                    color: AppColors.moodBarEmptyPrimary,
                    borderRadius: BorderRadius.circular(5),
                  ),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      5,
                      (index) => Container(
                        width: 30,
                        height: 30,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: AppColors.moodBarEmptyPrimary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.noRecord,
                    style: AppStyles.regular.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
