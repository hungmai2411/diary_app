import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/features/diary/models/diary.dart';
import 'package:diary_app/features/diary/models/mood.dart';
import 'package:diary_app/features/setting/models/setting.dart';
import 'package:diary_app/l10n/l10n.dart';
import 'package:diary_app/my_app.dart';
import 'package:diary_app/providers/bottom_navigation_provider.dart';
import 'package:diary_app/providers/date_provider.dart';
import 'package:diary_app/providers/diary_provider.dart';
import 'package:diary_app/providers/setting_provider.dart';
import 'package:diary_app/route.dart';
import 'package:diary_app/services/db_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DiaryAdapter());
  Hive.registerAdapter(MoodAdapter());
  Hive.registerAdapter(SettingAdapter());
  SettingProvider settingProvider = SettingProvider();
  await getSetting(settingProvider);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavigationProvider>(
          create: (_) => BottomNavigationProvider(),
        ),
        ChangeNotifierProvider<DiaryProvider>(
          create: (_) => DiaryProvider(),
        ),
        ChangeNotifierProvider<SettingProvider>(
          create: (_) => settingProvider,
        ),
        ChangeNotifierProvider<DateProvider>(
          create: (_) => DateProvider(),
        ),
      ],
      child: Consumer<SettingProvider>(builder: (
        context,
        model,
        child,
      ) {
        return MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.backgroundColor,
            appBarTheme: const AppBarTheme(
              systemOverlayStyle:
                  SystemUiOverlayStyle.dark, // set dark of light
            ),
          ),
          locale: model.setting.language == 'English'
              ? const Locale('en')
              : const Locale('vi'),
          supportedLocales: L10n.all,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            MonthYearPickerLocalizations.delegate,
          ],
          routes: routes,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: generateRoutes,
          home: const MyApp(),
        );
      }),
    ),
  );
}

getSetting(SettingProvider settingProvider) async {
  final DbHelper dbHelper = DbHelper();
  final box = await dbHelper.openBox("settings");
  Setting setting = dbHelper.getSetting(box);

  if (setting.language == null) {
    setting = setting.copyWith(
      language: 'English',
    );
  }
  if (setting.startingDayOfWeek == null) {
    setting = setting.copyWith(startingDayOfWeek: 'Sunday');
  }
  settingProvider.setSetting(setting);
}
