import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/features/setting/models/setting.dart';
import 'package:diary_app/providers/setting_provider.dart';
import 'package:diary_app/widgets/box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartOfTheWeekScreen extends StatefulWidget {
  const StartOfTheWeekScreen({super.key});
  static const String routeName = '/start_of_the_week_screen';

  @override
  State<StartOfTheWeekScreen> createState() => _StartOfTheWeekScreenState();
}

class _StartOfTheWeekScreenState extends State<StartOfTheWeekScreen> {
  final List days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  chooseStartDayOfTheWeek(String day) {
    final settingProvider = context.read<SettingProvider>();
    Setting setting = settingProvider.setting;
    setting = setting.copyWith(startingDayOfWeek: day);
    settingProvider.setSetting(setting);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final settingProvider = context.read<SettingProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.textPrimaryColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Start day of the week',
          style: AppStyles.regular.copyWith(fontSize: 16),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          String day = days[index];

          return GestureDetector(
            onTap: () => chooseStartDayOfTheWeek(day),
            child: Box(
              margin: const EdgeInsets.only(
                bottom: 10.0,
                left: 20,
                right: 20,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              child: Row(
                children: [
                  Text(
                    day,
                    style: AppStyles.medium.copyWith(
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  settingProvider.setting.startingDayOfWeek == day
                      ? Icon(
                          Icons.check,
                          color: AppColors.selectedColor,
                        )
                      : const SizedBox()
                ],
              ),
            ),
          );
        },
        itemCount: days.length,
      ),
    );
  }
}
