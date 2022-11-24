import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/features/diary/models/diary.dart';
import 'package:diary_app/features/diary/models/mood.dart';
import 'package:diary_app/my_app.dart';
import 'package:diary_app/providers/bottom_navigation_provider.dart';
import 'package:diary_app/providers/diary_provider.dart';
import 'package:diary_app/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DiaryAdapter());
  Hive.registerAdapter(MoodAdapter());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavigationProvider>(
          create: (_) => BottomNavigationProvider(),
        ),
        ChangeNotifierProvider<DiaryProvider>(
          create: (_) => DiaryProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.backgroundColor,
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark, // set dark of light
          ),
        ),
        routes: routes,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: generateRoutes,
        home: const MyApp(),
      ),
    ),
  );
}
