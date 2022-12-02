import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/features/board/widgets/mood_bar.dart';
import 'package:diary_app/features/board/widgets/mood_flow.dart';
import 'package:diary_app/features/diary/models/diary.dart';
import 'package:diary_app/features/setting/models/setting.dart';
import 'package:diary_app/providers/diary_provider.dart';
import 'package:diary_app/providers/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quiver/time.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int tabIndex = 0;
  DateTime selectedTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
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

    diaries.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    for (Diary diary in diaries) {
      DateTime createdAt = diary.createdAt;

      if (createdAt.month == selectedTime.month &&
          createdAt.year == selectedTime.year) {
        diariesMonth.add(diary);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Mood Board',
          style: AppStyles.semibold.copyWith(fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('MMM yyyy', locale).format(selectedTime),
                          style: AppStyles.medium.copyWith(
                            fontSize: 18,
                          ),
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
                    const Divider(
                      color: AppColors.textSecondaryColor,
                    ),
                    TabBar(
                      controller: tabController,
                      labelStyle: AppStyles.medium,
                      indicatorColor: AppColors.selectedColor,
                      labelColor: AppColors.selectedColor,
                      tabs: const [
                        Tab(text: 'Monthly'),
                        Tab(text: 'Annual'),
                      ],
                      onTap: (value) {
                        setState(
                          () {
                            tabIndex = value;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Column(
                      children: [
                        MoodFlow(
                          month: selectedTime.month,
                          year: selectedTime.year,
                          numOfDays: daysInMonth(
                            selectedTime.year,
                            selectedTime.month,
                          ),
                          diariesMonth: diariesMonth,
                        ),
                        const SizedBox(height: 20),
                        MoodBar(
                          diariesMonth: diariesMonth,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        MoodFlow(
                          month: selectedTime.month,
                          isMonthly: false,
                          year: selectedTime.year,
                          diariesMonth: diariesMonth,
                        ),
                        const SizedBox(height: 20),
                        MoodBar(
                          diariesMonth: diariesMonth,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}