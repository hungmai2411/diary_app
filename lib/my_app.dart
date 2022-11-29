import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/features/diary/models/diary.dart';
import 'package:diary_app/features/diary/screens/add_diary_screen.dart';
import 'package:diary_app/features/diary/screens/diary_screen.dart';
import 'package:diary_app/features/setting/screens/setting_screen.dart';
import 'package:diary_app/providers/date_provider.dart';
import 'package:diary_app/providers/diary_provider.dart';
import 'package:diary_app/services/db_helpers.dart';
import 'package:diary_app/widgets/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'providers/bottom_navigation_provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static const routeName = '/my_app';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DbHelper dbHelper = DbHelper();

  List screens = [
    const DiaryScreen(),
    Container(),
    Container(),
    const SettingScreen(),
  ];

  navigateToAddDiaryScreen(DateTime dateTime) {
    Navigator.pushNamed(
      context,
      AddDiaryScreen.routeName,
      arguments: dateTime,
    );
  }

  @override
  void initState() {
    super.initState();
    getDiaries();
  }

  getDiaries() async {
    var diaryProvider = Provider.of<DiaryProvider>(context, listen: false);
    final box = await dbHelper.openBox("diaries");
    List<Diary> diaries = dbHelper.getDiaries(box);
    diaryProvider.setDiaries(diaries);
  }

  @override
  Widget build(BuildContext context) {
    var bottomProvider = Provider.of<BottomNavigationProvider>(context);
    var dateProvider = Provider.of<DateProvider>(context);
    print(dateProvider.selectedDay);
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.backgroundColor,
      body: screens[bottomProvider.currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // left tab icon
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabWidget(
                    iconData: FontAwesomeIcons.bookOpen,
                    onPressed: () {
                      bottomProvider.currentIndex = 0;
                    },
                    name: 'Diary',
                    color: bottomProvider.currentIndex == 0
                        ? AppColors.primaryColor
                        : AppColors.textSecondColor,
                  ),
                  TabWidget(
                    onPressed: () {
                      bottomProvider.currentIndex = 1;
                    },
                    iconData: FontAwesomeIcons.globe,
                    name: 'Challenge',
                    color: bottomProvider.currentIndex == 1
                        ? AppColors.primaryColor
                        : AppColors.textSecondColor,
                  ),
                ],
              ),
              // right tab icon
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabWidget(
                    onPressed: () {
                      bottomProvider.currentIndex = 2;
                    },
                    iconData: FontAwesomeIcons.chartSimple,
                    name: 'Board',
                    color: bottomProvider.currentIndex == 2
                        ? AppColors.primaryColor
                        : AppColors.textSecondColor,
                  ),
                  TabWidget(
                    onPressed: () {
                      bottomProvider.currentIndex = 3;
                    },
                    iconData: FontAwesomeIcons.gear,
                    name: 'Setting',
                    color: bottomProvider.currentIndex == 3
                        ? AppColors.primaryColor
                        : AppColors.textSecondColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToAddDiaryScreen(dateProvider.selectedDay),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.selectedColor,
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 35,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
