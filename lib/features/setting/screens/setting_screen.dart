import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/features/setting/models/setting.dart';
import 'package:diary_app/features/setting/screens/language_screen.dart';
import 'package:diary_app/features/setting/screens/passcode_screen.dart';
import 'package:diary_app/features/setting/screens/start_of_the_week_screen.dart';
import 'package:diary_app/features/setting/widgets/custom_app_bar.dart';
import 'package:diary_app/providers/setting_provider.dart';
import 'package:diary_app/services/notification_services.dart';
import 'package:diary_app/widgets/box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool hasPasscode = false;
  final ScrollController settingController = ScrollController();

  TimeOfDay reminderTime = const TimeOfDay(
    hour: 20,
    minute: 00,
  );

  chooseReminderTime(BuildContext context) async {
    final settingProvider = context.read<SettingProvider>();

    final TimeOfDay? value = await showTimePicker(
      context: context,
      initialTime: reminderTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (value != null) {
      Setting setting = settingProvider.setting;
      setting = setting.copyWith(
        reminderHour: value.hour,
        reminderMinute: value.minute,
      );
      settingProvider.setSetting(setting);
      DateTime now = DateTime.now();
      await NotificationsServices.init(initScheduled: true);
      await NotificationsServices.showScheduledNotification(
        scheduledDate: DateTime(
          now.year,
          now.month,
          now.day,
        ),
        minute: value.minute,
        hour: value.hour,
        payload: 'hihi',
        title: 'Diary Application',
        body: 'Don\'t forget to check in your mood today.\nHave a good night!',
      );
    }
  }

  navigateToStartOfTheWeekScreen() {
    Navigator.pushNamed(
      context,
      StartOfTheWeekScreen.routeName,
    );
  }

  navigateToLanguageScreen() {
    Navigator.pushNamed(
      context,
      LanguageScreen.routeName,
    );
  }

  navigateToPasscodeScreen() {
    Navigator.pushNamed(
      context,
      PasscodeScreen.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingProvider = Provider.of<SettingProvider>(context);
    Setting setting = settingProvider.setting;
    print(setting.startingDayOfWeek);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: CustomAppBar(scrollController: settingController),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          controller: settingController,
          children: [
            // general text
            Text(AppLocalizations.of(context)!.general,
                style: AppStyles.medium),
            const SizedBox(height: 10),
            // passcode
            GestureDetector(
              onTap: navigateToPasscodeScreen,
              child: Box(
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
                    Text(AppLocalizations.of(context)!.passcode,
                        style: AppStyles.medium),
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
                  Text(AppLocalizations.of(context)!.backUp,
                      style: AppStyles.medium),
                ],
              ),
            ),
            const SizedBox(height: 15),
            // remider time
            GestureDetector(
              onTap: () => chooseReminderTime(context),
              child: Box(
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
                        Text(AppLocalizations.of(context)!.reminderTime,
                            style: AppStyles.medium),
                        Text(
                          '${setting.reminderHour}:${setting.reminderMinute}',
                          style: AppStyles.regular.copyWith(
                            color: AppColors.selectedColor,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    CupertinoSwitch(
                      // This bool value toggles the switch.
                      value: setting.hasReminderTime,
                      thumbColor: setting.hasReminderTime
                          ? AppColors.selectedColor
                          : AppColors.thumUnSelectedColor,
                      trackColor: AppColors.trackUnSelectedColor,
                      activeColor: AppColors.trackSelectedColor,
                      onChanged: (bool? value) {
                        setting = setting.copyWith(hasReminderTime: value);
                        settingProvider.setSetting(setting);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            // start of the week
            GestureDetector(
              onTap: navigateToStartOfTheWeekScreen,
              child: Box(
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
                    Text(AppLocalizations.of(context)!.startOfTheWeek,
                        style: AppStyles.medium),
                    const Spacer(),
                    Text(
                      setting.startingDayOfWeek!,
                      style: AppStyles.medium.copyWith(
                        color: AppColors.selectedColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            // language
            GestureDetector(
              onTap: navigateToLanguageScreen,
              child: Box(
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
                    Text(AppLocalizations.of(context)!.language,
                        style: AppStyles.medium),
                    const Spacer(),
                    Text(
                      setting.language!,
                      style: AppStyles.medium.copyWith(
                        color: AppColors.selectedColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
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
                  Text(AppLocalizations.of(context)!.changeTheme,
                      style: AppStyles.medium),
                  const Spacer(),
                  Text(
                    'Paradise Beach',
                    style: AppStyles.medium.copyWith(
                      color: AppColors.selectedColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            // general text
            Text(AppLocalizations.of(context)!.other, style: AppStyles.medium),
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
                  Text(AppLocalizations.of(context)!.privacyPolicy,
                      style: AppStyles.medium),
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
                    Icons.lock_outline,
                    color: AppColors.textSecondColor,
                  ),
                  const SizedBox(width: 8),
                  Text(AppLocalizations.of(context)!.termsOfConditions,
                      style: AppStyles.medium),
                ],
              ),
            ),
            const SizedBox(height: 15),
            // feedback
            Box(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.question_mark_outlined,
                    color: AppColors.textSecondColor,
                  ),
                  const SizedBox(width: 8),
                  Text(AppLocalizations.of(context)!.feedback,
                      style: AppStyles.medium),
                ],
              ),
            ),
            const SizedBox(height: 15),
            // about us
            Box(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: AppColors.textSecondColor,
                  ),
                  const SizedBox(width: 8),
                  Text(AppLocalizations.of(context)!.aboutUs,
                      style: AppStyles.medium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // String change(String day, String language){
  //   if(language == 'English'){

  //   }
  // }
}
