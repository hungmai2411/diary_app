import 'package:diary_app/features/diary/models/diary.dart';
import 'package:diary_app/features/diary/screens/add_diary_screen.dart';
import 'package:diary_app/features/diary/screens/detail_diary_screen.dart';
import 'package:diary_app/features/diary/screens/diary_screen.dart';
import 'package:diary_app/features/diary/screens/document_screen.dart';
import 'package:diary_app/features/diary/screens/edit_diary_screen.dart';
import 'package:diary_app/features/diary/screens/share_screen.dart';
import 'package:diary_app/features/setting/screens/language_screen.dart';
import 'package:diary_app/features/setting/screens/passcode_confirm_screen.dart';
import 'package:diary_app/features/setting/screens/passcode_screen.dart';
import 'package:diary_app/features/setting/screens/setting_screen.dart';
import 'package:diary_app/features/setting/screens/start_of_the_week_screen.dart';
import 'package:diary_app/my_app.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  MyApp.routeName: (context) => const MyApp(),
  DiaryScreen.routeName: (context) => const DiaryScreen(),
  StartOfTheWeekScreen.routeName: (context) => const StartOfTheWeekScreen(),
  LanguageScreen.routeName: (context) => const LanguageScreen(),
  PasscodeScreen.routeName: (context) => const PasscodeScreen(),
  SettingScreen.routeName: (context) => const SettingScreen(),
};

MaterialPageRoute<dynamic>? generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case AddDiaryScreen.routeName:
      final DateTime dateTime = settings.arguments as DateTime;
      return MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (context) => AddDiaryScreen(
          dateTime: dateTime,
        ),
      );
    case EditDiaryScreen.routeName:
      final Diary diary = settings.arguments as Diary;
      return MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (context) => EditDiaryScreen(
          diary: diary,
        ),
      );
    case DetailDiaryScreen.routeName:
      final Diary diary = settings.arguments as Diary;
      return MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (context) => DetailDiaryScreen(
          diary: diary,
        ),
      );
    case DocumentScreen.routeName:
      return MaterialPageRoute<String>(
        settings: settings,
        builder: (context) => const DocumentScreen(),
      );
    case PasscodeConfirmScreen.routeName:
      final String passcode = settings.arguments as String;
      return MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (context) => PasscodeConfirmScreen(passcode: passcode),
      );
    case ShareScreen.routeName:
      final List images = settings.arguments as List;
      print(images);
      return MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (context) => ShareScreen(
          bytes1: images[0],
          bytes2: images[1],
        ),
      );
  }
}
