import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/features/board/widgets/mood_bar.dart';
import 'package:diary_app/features/board/widgets/mood_flow.dart';
import 'package:diary_app/features/diary/models/diary.dart';
import 'package:diary_app/features/diary/widgets/item_diary.dart';
import 'package:diary_app/features/diary/widgets/item_no_diary.dart';
import 'package:diary_app/features/setting/models/setting.dart';
import 'package:diary_app/features/time_line/screens/time_line_screen.dart';
import 'package:diary_app/providers/date_provider.dart';
import 'package:diary_app/providers/diary_provider.dart';
import 'package:diary_app/providers/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';
import 'package:provider/provider.dart';
import 'package:quiver/time.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  DateTime selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedDay = context.read<DateProvider>().selectedDay;
  }

  @override
  void dispose() {
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    final SettingProvider settingProvider = context.read<SettingProvider>();
    Setting setting = settingProvider.setting;
    String locale = setting.language == 'English' ? 'en' : 'vi';
    final size = MediaQuery.of(context).size;
    final DiaryProvider diaryProvider = context.watch<DiaryProvider>();
    List<Diary> diaries = diaryProvider.diaries;
    List<Diary> diariesMonth = [];
    List<Diary> diariesYear = [];

    diaries.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    for (Diary diary in diaries) {
      DateTime createdAt = diary.createdAt;

      if (createdAt.month == selectedDay.month &&
          createdAt.year == selectedDay.year) {
        diariesMonth.add(diary);
      }

      if (createdAt.year == selectedDay.year) {
        diariesYear.add(diary);
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
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
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              MoodFlow(
                month: selectedDay.month,
                year: selectedDay.year,
                numOfDays: daysInMonth(
                  selectedDay.year,
                  selectedDay.month,
                ),
                diaries: diariesMonth,
              ),
              const SizedBox(height: 20),
              MoodBar(
                diariesMonth: diariesMonth,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.timeLineTab,
                      style: AppStyles.medium,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          TimeLineScreen.routeName,
                          arguments: diariesMonth,
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.seeAll,
                        style: AppStyles.medium.copyWith(
                          color: AppColors.todayColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              diariesMonth.isEmpty
                  ? const SizedBox(
                      width: double.infinity,
                      child: ItemNoDiary(),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          Diary diary = diariesMonth[index];
                          return ItemDiary(diary: diary);
                        },
                        itemCount: diariesMonth.length,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
