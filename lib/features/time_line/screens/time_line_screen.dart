import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/constants/bean.dart';
import 'package:diary_app/features/diary/models/diary.dart';
import 'package:diary_app/features/diary/models/mood.dart';
import 'package:diary_app/features/diary/widgets/item_diary.dart';
import 'package:diary_app/features/diary/widgets/item_no_diary.dart';
import 'package:diary_app/features/setting/models/setting.dart';
import 'package:diary_app/providers/diary_provider.dart';
import 'package:diary_app/providers/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../constants/app_colors.dart';

class TimeLineScreen extends StatefulWidget {
  const TimeLineScreen({super.key});

  @override
  State<TimeLineScreen> createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {
  List<Diary> diariesMonth = [];
  bool isSort = false;
  DateTime selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  chooseMonth(String locale) async {
    showMonthPicker(
      context: context,
      initialDate: selectedDay,
      locale: locale != 'en' ? const Locale('vi') : null,
      roundedCornersRadius: 8,
      unselectedMonthTextColor: AppColors.textSecondaryColor,
      headerColor: AppColors.selectedColor,
      cancelText: Text(
        AppLocalizations.of(context)!.cancel,
        style: const TextStyle(
          color: AppColors.textSecondaryColor,
        ),
      ),
      confirmText: Text(
        AppLocalizations.of(context)!.ok,
        style: TextStyle(
          color: AppColors.selectedColor,
        ),
      ),
    ).then((date) {
      if (date != null) {
        setState(() {
          selectedDay = date;
        });
      }
    });
  }

  getDiariesPerMonth(DateTime selectedDay) {
    diariesMonth = [];
    final DiaryProvider diaryProvider = context.read<DiaryProvider>();
    List<Diary> diaries = diaryProvider.diaries;
    final SettingProvider settingProvider = context.read<SettingProvider>();
    Setting setting = settingProvider.setting;
    Bean bean = setting.bean;
    diaries.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    for (Diary diary in diaries) {
      DateTime createdAt = diary.createdAt;

      if (createdAt.month == selectedDay.month &&
          createdAt.year == selectedDay.year) {
        int indexOfMood = 5 - diary.mood.getIndex().round();
        String imageMood = bean.beans[indexOfMood];
        String moodName = diary.mood.name;
        diary = diary.copyWith(mood: Mood(name: moodName, image: imageMood));
        diariesMonth.add(diary);
      }
    }

    if (isSort) {
      diariesMonth.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else {
      diariesMonth.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }
  }

  @override
  Widget build(BuildContext context) {
    final SettingProvider settingProvider = context.read<SettingProvider>();
    Setting setting = settingProvider.setting;
    String locale = setting.language == 'English' ? 'en' : 'vi';

    getDiariesPerMonth(selectedDay);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 3,
            ),
            GestureDetector(
              onTap: () => chooseMonth(locale),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('MMM, yyyy', locale).format(selectedDay),
                    style: AppStyles.medium.copyWith(fontSize: 18),
                  ),
                  const SizedBox(width: 6),
                  // choose time
                  const Icon(
                    FontAwesomeIcons.angleDown,
                    size: 18,
                    color: AppColors.textPrimaryColor,
                  ),
                ],
              ),
            ),
            const Spacer(flex: 2),
            GestureDetector(
              onTap: () {
                setState(() {
                  isSort = !isSort;
                });
              },
              child: const Icon(
                Icons.sort_rounded,
                color: AppColors.textPrimaryColor,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: diariesMonth.isEmpty
          ? const SizedBox(
              width: double.infinity,
              child: ItemNoDiary(),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                Diary diary = diariesMonth[index];
                return ItemDiary(diary: diary);
              },
              itemCount: diariesMonth.length,
            ),
    );
  }
}
