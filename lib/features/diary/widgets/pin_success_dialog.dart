import 'package:diary_app/constants/app_assets.dart';
import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PinSuccessDialog extends StatelessWidget {
  const PinSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.pinSet,
          style: AppStyles.medium.copyWith(),
        ),
        const SizedBox(height: 15),
        AppButton(
          onTap: () => Navigator.pop(context),
          textButton: AppLocalizations.of(context)!.ok,
        ),
      ],
    );
  }
}
