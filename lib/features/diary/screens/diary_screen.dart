import 'package:diary_app/constants/app_assets.dart';
import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/constants/utils.dart';
import 'package:diary_app/extensions/string_ext.dart';
import 'package:diary_app/features/diary/models/diary.dart';
import 'package:diary_app/features/diary/screens/add_diary_screen.dart';
import 'package:diary_app/features/diary/screens/detail_diary_screen.dart';
import 'package:diary_app/features/diary/screens/share_screen.dart';
import 'package:diary_app/features/diary/widgets/item_date.dart';
import 'package:diary_app/features/diary/widgets/item_diary.dart';
import 'package:diary_app/features/setting/models/setting.dart';
import 'package:diary_app/providers/date_provider.dart';
import 'package:diary_app/providers/diary_provider.dart';
import 'package:diary_app/providers/setting_provider.dart';
import 'package:diary_app/widgets/widget_to_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});
  static const String routeName = '/diary_screen';
  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey? key1;
  Uint8List? bytes1;

  GlobalKey? key2;
  Uint8List? bytes2;

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

  navigateToDetailDiaryScreen(Diary diary) {
    Navigator.pushNamed(
      context,
      DetailDiaryScreen.routeName,
      arguments: diary,
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

  List<Diary> getDiaryOfDay(DateTime dateTime, List<Diary> diaries) {
    List<Diary> diariesTmp = [];

    print('run func get icon of day');
    for (var diary in diaries) {
      if (dateTime.day == diary.createdAt.day &&
          dateTime.month == diary.createdAt.month &&
          dateTime.year == diary.createdAt.year) {
        diariesTmp.add(diary);
      }
    }

    return diariesTmp;
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
    List<Diary> diariesOfDay = getDiaryOfDay(dateProvider.selectedDay, diaries);
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
            automaticallyImplyLeading: false,
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
                      WidgetToImage(builder: (key) {
                        key1 = key;
                        return Text(
                          DateFormat('MMM dd, yyyy', locale)
                              .format(dateProvider.selectedDay),
                          style: AppStyles.medium.copyWith(fontSize: 18),
                        );
                      }),
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
                GestureDetector(
                  onTap: () async {
                    // Lấy dữ liệu của widget theo key.
                    final bytes1 = await capture(key1);
                    final bytes2 = await capture(key2);
                    setState(() {
                      this.bytes1 = bytes1;
                      this.bytes2 = bytes2;
                    });
                    Navigator.pushNamed(
                      context,
                      ShareScreen.routeName,
                      arguments: [this.bytes1, this.bytes2],
                    );
                  },
                  child: const Icon(
                    Icons.ios_share,
                    color: AppColors.textPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.width,
              child: WidgetToImage(
                builder: (key) {
                  key2 = key;
                  return TableCalendar(
                    startingDayOfWeek:
                        setting.startingDayOfWeek!.getStartingDayOfWeek,
                    shouldFillViewport: true,
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context1, datetime, events) {
                        return GestureDetector(
                          onTap: () {
                            if (!isSameDay(
                                    datetime, dateProvider.selectedDay) &&
                                datetime.compareTo(DateTime.now()) == -1) {
                              dateProvider.setDay(datetime);
                            } else {
                              showSnackBar(
                                context,
                                AppLocalizations.of(context)!
                                    .youCannotRecordThefuture,
                              );
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
                  );
                },
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
                (
                  BuildContext context,
                  int index,
                ) {
                  if (index == diariesOfDay.length) {
                    return Container(
                      height: 50,
                    );
                  }
                  Diary diary = diariesOfDay[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: GestureDetector(
                      onTap: () => navigateToDetailDiaryScreen(diary),
                      child: ItemDiary(diary: diary),
                    ),
                  );
                },
                childCount: diariesOfDay.length + 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
