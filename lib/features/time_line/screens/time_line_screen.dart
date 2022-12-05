import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/features/diary/models/diary.dart';
import 'package:diary_app/features/diary/widgets/item_diary.dart';
import 'package:diary_app/features/setting/models/setting.dart';
import 'package:diary_app/providers/diary_provider.dart';
import 'package:diary_app/providers/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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

  chooseMonth() async {
    DatePicker.showDatePicker(
      context,
      dateFormat: 'MMMM-yyyy',
      minDateTime: DateTime(2022),
      onConfirm: (dateTime, selectedIndex) {
        setState(() {
          selectedDay = dateTime;
        });
      },
    );
  }

  getDiariesPerMonth(DateTime selectedDay) {
    diariesMonth = [];
    final DiaryProvider diaryProvider = context.read<DiaryProvider>();
    List<Diary> diaries = diaryProvider.diaries;

    diaries.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    for (Diary diary in diaries) {
      DateTime createdAt = diary.createdAt;

      if (createdAt.month == selectedDay.month &&
          createdAt.year == selectedDay.year) {
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 3,
            ),
            GestureDetector(
              onTap: chooseMonth,
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
      body: ListView.builder(
        itemBuilder: (context, index) {
          Diary diary = diariesMonth[index];
          return Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20,
              bottom: 10,
            ),
            child: ItemDiary(diary: diary),
          );
        },
        itemCount: diariesMonth.length,
      ),
    );
  }
}
