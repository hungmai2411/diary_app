import 'package:diary_app/constants/app_assets.dart';
import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/features/diary/models/diary.dart';
import 'package:diary_app/features/diary/screens/add_diary_screen.dart';
import 'package:diary_app/features/diary/widgets/item_date.dart';
import 'package:diary_app/features/diary/widgets/item_diary.dart';
import 'package:diary_app/providers/diary_provider.dart';
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
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });
  }

  navigateToAddDiaryScreen(DateTime dateTime) {
    Navigator.pushNamed(
      context,
      AddDiaryScreen.routeName,
      arguments: dateTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    final DiaryProvider diaryProvider = Provider.of<DiaryProvider>(context);
    final kToday = DateTime.now();
    final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
    final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
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
                  '500',
                  style: AppStyles.semibold.copyWith(fontSize: 16),
                ),
                const Spacer(),
                // datetime
                Text(
                  DateFormat('dd MMM, yyyy').format(DateTime.now()),
                  style: AppStyles.medium.copyWith(fontSize: 18),
                ),
                const SizedBox(width: 6),
                // choose time
                const Icon(
                  FontAwesomeIcons.angleDown,
                  size: 18,
                  color: AppColors.textPrimaryColor,
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
                shouldFillViewport: true,
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, datetime, events) {
                    return GestureDetector(
                      onTap: () {
                        if (!isSameDay(datetime, _selectedDay)) {
                          setState(() {
                            _selectedDay = datetime;
                            _focusedDay = datetime;
                          });
                        }
                      },
                      child: GestureDetector(
                        onTap: () => navigateToAddDiaryScreen(datetime),
                        child: ItemDate(
                          date: datetime.day.toString(),
                        ),
                      ),
                    );
                  },
                  todayBuilder: (context, datetime, events) {
                    return ItemDate(
                      date: datetime.day.toString(),
                      color: AppColors.todayColor,
                    );
                  },
                  selectedBuilder: (context, datetime, events) {
                    return ItemDate(
                      date: datetime.day.toString(),
                      color: AppColors.selectedColor,
                    );
                  },
                ),
                headerVisible: false,
                firstDay: kFirstDay,
                rangeSelectionMode: _rangeSelectionMode,
                lastDay: kLastDay,
                rangeStartDay: _rangeStart,
                rangeEndDay: _rangeEnd,
                onRangeSelected: _onRangeSelected,
                calendarFormat: CalendarFormat.month,
                focusedDay: _focusedDay,
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(selectedDay, _selectedDay)) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      // update `_focusedDay` here as well
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: false,
                ),
                locale: 'en_US',
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
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
                  Diary diary = diaryProvider.diaries[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: ItemDiary(diary: diary),
                  );
                },
                childCount: diaryProvider.diaries.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Text(
              AppLocalizations.of(context)!.language,
            ),
          )
        ],
      ),
    );
  }
}
