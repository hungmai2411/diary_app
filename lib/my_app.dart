import 'package:diary_app/constants/app_colors.dart';
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
  List screens = [
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: screens[provider.currentIndex],
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
                      provider.currentIndex = 0;
                    },
                    name: 'Diary',
                    color: provider.currentIndex == 0
                        ? AppColors.primaryColor
                        : AppColors.textSecondColor,
                  ),
                  TabWidget(
                    onPressed: () {
                      provider.currentIndex = 1;
                    },
                    iconData: FontAwesomeIcons.globe,
                    name: 'Challenge',
                    color: provider.currentIndex == 1
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
                      provider.currentIndex = 2;
                    },
                    iconData: FontAwesomeIcons.chartLine,
                    name: 'Board',
                    color: provider.currentIndex == 2
                        ? AppColors.primaryColor
                        : AppColors.textSecondColor,
                  ),
                  TabWidget(
                    onPressed: () {
                      provider.currentIndex = 3;
                    },
                    iconData: FontAwesomeIcons.gear,
                    name: 'Setting',
                    color: provider.currentIndex == 3
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
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.gradient,
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 35,
          ),
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
