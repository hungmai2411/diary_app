import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/widgets/box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool hasPasscode = false;
  bool hasReminderTime = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Setting',
          style: AppStyles.semibold.copyWith(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            // general text
            Text('General', style: AppStyles.medium),
            const SizedBox(height: 10),
            // passcode
            Box(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outline,
                    color: AppColors.textSecondColor,
                  ),
                  const SizedBox(width: 8),
                  Text('Passcode', style: AppStyles.medium),
                  const Spacer(),
                  CupertinoSwitch(
                    // This bool value toggles the switch.
                    value: hasPasscode,
                    thumbColor: hasPasscode
                        ? AppColors.selectedColor
                        : AppColors.thumUnSelectedColor,
                    trackColor: AppColors.trackUnSelectedColor,
                    activeColor: AppColors.trackSelectedColor,
                    onChanged: (bool? value) {
                      // This is called when the user toggles the switch.
                      setState(() {
                        hasPasscode = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            // backup
            Box(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.backup_outlined,
                    color: AppColors.textSecondColor,
                  ),
                  const SizedBox(width: 8),
                  Text('Backup and restore', style: AppStyles.medium),
                ],
              ),
            ),
            const SizedBox(height: 15),
            // remider time
            Box(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none_sharp,
                    color: AppColors.textSecondColor,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Reminder time', style: AppStyles.medium),
                      Text(
                        '20:00 CH',
                        style: AppStyles.regular.copyWith(
                          color: AppColors.textSecondColor,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CupertinoSwitch(
                    // This bool value toggles the switch.
                    value: hasReminderTime,
                    thumbColor: hasReminderTime
                        ? AppColors.selectedColor
                        : AppColors.thumUnSelectedColor,
                    trackColor: AppColors.trackUnSelectedColor,
                    activeColor: AppColors.trackSelectedColor,
                    onChanged: (bool? value) {
                      // This is called when the user toggles the switch.
                      setState(() {
                        hasReminderTime = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            // start of the week
            Box(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    color: AppColors.textSecondColor,
                  ),
                  const SizedBox(width: 8),
                  Text('Start of the week', style: AppStyles.medium),
                  const Spacer(),
                  Text(
                    'Monday',
                    style: AppStyles.medium.copyWith(
                      color: AppColors.selectedColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            // language
            Box(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.language_rounded,
                    color: AppColors.textSecondColor,
                  ),
                  const SizedBox(width: 8),
                  Text('Language', style: AppStyles.medium),
                  const Spacer(),
                  Text(
                    'English',
                    style: AppStyles.medium.copyWith(
                      color: AppColors.selectedColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            // theme
            Box(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_outlined,
                    color: AppColors.textSecondColor,
                  ),
                  const SizedBox(width: 8),
                  Text('Change theme', style: AppStyles.medium),
                  const Spacer(),
                  Text(
                    'Paradise Beach',
                    style: AppStyles.medium.copyWith(
                      color: AppColors.selectedColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            // general text
            Text('About us', style: AppStyles.medium),
            const SizedBox(height: 10),
            // privacy policy
            Box(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outline,
                    color: AppColors.textSecondColor,
                  ),
                  const SizedBox(width: 8),
                  Text('Privacy Policy', style: AppStyles.medium),
                ],
              ),
            ),
            const SizedBox(height: 15),
            // terms
            Box(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.file_open_outlined,
                    color: AppColors.textSecondColor,
                  ),
                  const SizedBox(width: 8),
                  Text('Terms of the service', style: AppStyles.medium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
