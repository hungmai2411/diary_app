import 'package:another_flushbar/flushbar.dart';
import 'package:diary_app/constants/app_assets.dart';
import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/constants/utils.dart';
import 'package:diary_app/extensions/string_ext.dart';
import 'package:diary_app/features/diary/models/diary.dart';
import 'package:diary_app/features/diary/screens/add_diary_screen.dart';
import 'package:diary_app/features/diary/widgets/item_date.dart';
import 'package:diary_app/features/diary/widgets/item_diary.dart';
import 'package:diary_app/features/setting/models/setting.dart';
import 'package:diary_app/providers/date_provider.dart';
import 'package:diary_app/providers/diary_provider.dart';
import 'package:diary_app/providers/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  navigateToAddDiaryScreen(DateTime dateTime) {
    Navigator.pushNamed(
      context,
      AddDiaryScreen.routeName,
      arguments: dateTime,
    );
  }

  String? getIconOfDay(DateTime dateTime, List<Diary> diaries) {
    print('run func get icon of day');
    for (var diary in diaries) {
      if (dateTime.day == diary.createdAt.day &&
          dateTime.month == diary.createdAt.month &&
          dateTime.year == diary.createdAt.year) {
        return diary.mood.image;
      }
    }

    return null;
  }

  void chooseDate() async {
    final dateProvider = context.read<DateProvider>();

    final result = await showDatePicker(
      context: context,
      initialDate: dateProvider.selectedDay,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (result != null) {
      dateProvider.setDay(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final SettingProvider settingProvider = context.read<SettingProvider>();
    final DateProvider dateProvider = context.watch<DateProvider>();
    final DiaryProvider diaryProvider = context.watch<DiaryProvider>();
    List<Diary> diaries = diaryProvider.diaries;
    Setting setting = settingProvider.setting;
    String locale = setting.language == 'English' ? 'en' : 'vi';
    final kToday = DateTime.now();
    final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
    final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
    print(setting.point);

    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.iconCoin,
                  width: 20,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 6),
                // coin
                Text(
                  setting.point.toString(),
                  style: AppStyles.semibold.copyWith(fontSize: 16),
                ),
                const Spacer(),
                // datetime
                GestureDetector(
                  onTap: chooseDate,
                  child: Row(
                    children: [
                      Text(
                        DateFormat('MMM dd, yyyy', locale)
                            .format(dateProvider.selectedDay),
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
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.width,
              child: TableCalendar(
                startingDayOfWeek:
                    setting.startingDayOfWeek.getStartingDayOfWeek,
                shouldFillViewport: true,
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context1, datetime, events) {
                    return GestureDetector(
                      onTap: () {
                        if (!isSameDay(datetime, dateProvider.selectedDay) &&
                            datetime.compareTo(DateTime.now()) == -1) {
                          dateProvider.setDay(datetime);
                        } else {
                          showSnackBar(context, 'You cannot record the future');
                        }
                      },
                      child: ItemDate(
                        date: datetime.day.toString(),
                        img: getIconOfDay(datetime, diaries),
                      ),
                    );
                  },
                  todayBuilder: (context, datetime, events) {
                    return GestureDetector(
                      onTap: () {
                        dateProvider.setDay(datetime);
                      },
                      child: ItemDate(
                        date: datetime.day.toString(),
                        color: AppColors.todayColor,
                        img: getIconOfDay(datetime, diaries),
                      ),
                    );
                  },
                  selectedBuilder: (context, datetime, events) {
                    return ItemDate(
                      date: datetime.day.toString(),
                      color: AppColors.primaryColor,
                      img: getIconOfDay(datetime, diaries),
                      isSelected: true,
                    );
                  },
                ),
                headerVisible: false,
                firstDay: kFirstDay,
                lastDay: kLastDay,
                calendarFormat: CalendarFormat.month,
                focusedDay: dateProvider.focusedDay,
                onPageChanged: (focusedDay) {
                  dateProvider.setDay(focusedDay);
                },
                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: false,
                ),
                locale: locale,
                selectedDayPredicate: (day) =>
                    isSameDay(dateProvider.selectedDay, day),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  Diary diary = diaries[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: ItemDiary(diary: diary),
                  );
                },
                childCount: diaries.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
