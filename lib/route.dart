import 'package:diary_app/features/diary/screens/add_diary_screen.dart';
import 'package:diary_app/my_app.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  MyApp.routeName: (context) => const MyApp(),
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
  }
}
