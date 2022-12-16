import 'package:carousel_slider/carousel_slider.dart';
import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/constants/bean.dart';
import 'package:diary_app/features/setting/models/setting.dart';
import 'package:diary_app/features/setting/screens/theme_store_screen.dart';
import 'package:diary_app/features/setting/widgets/item_background.dart';
import 'package:diary_app/features/setting/widgets/item_bean.dart';
import 'package:diary_app/providers/setting_provider.dart';
import 'package:diary_app/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SelectThemeScreen extends StatefulWidget {
  const SelectThemeScreen({super.key});
  static const String routeName = '/select_theme_screen';
  @override
  State<SelectThemeScreen> createState() => _SelectThemeScreenState();
}

class _SelectThemeScreenState extends State<SelectThemeScreen> {
  late SettingProvider settingProvider;
  late Setting setting;
  final CarouselController controller = CarouselController();
  late String background;
  late Bean beanSelected;

  @override
  void initState() {
    super.initState();
    settingProvider = context.read<SettingProvider>();
    setting = settingProvider.setting;
    beanSelected = setting.bean;
    background = setting.background;
  }

  @override
  void dispose() {
    super.dispose();
  }

  int getInitialPage() {
    Bean bean = setting.bean;

    switch (bean.nameBean) {
      case 'Basic Bean':
        return 0;
      case 'Blushing Bean':
        return 1;
      case 'Kitty Bean':
        return 2;

      default:
        return 3;
    }
  }

  setTheme() {
    setting = setting.copyWith(
      bean: beanSelected,
      background: background,
    );

    if (background == 'System mode') {
      var brightness = MediaQuery.of(context).platformBrightness;
      bool isDarkMode = brightness == Brightness.dark;
      background = isDarkMode ? 'Dark mode' : 'Light mode';
    }
    AppColors.changeTheme(background);
    settingProvider.setSetting(setting);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final settingProvider = context.watch<SettingProvider>();
    Setting setting = settingProvider.setting;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appbarColor,
        elevation: 0.3,
        automaticallyImplyLeading: false,
        title: Text(
          AppLocalizations.of(context)!.changeTheme,
          style: AppStyles.medium.copyWith(
            fontSize: 18,
            color: AppColors.textPrimaryColor,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.textPrimaryColor,
            size: 21,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, ThemeStoreScreen.routeName);
            },
            icon: Icon(
              Icons.add_shopping_cart_outlined,
              color: AppColors.textPrimaryColor,
              size: 21,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.background,
              style: AppStyles.medium.copyWith(
                color: AppColors.textPrimaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      background = 'System mode';
                    });
                  },
                  child: ItemBackground(
                    backgroundSelected: background,
                    color: AppColors.textPrimaryColor,
                    background: AppLocalizations.of(context)!.systemMode,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      background = 'Dark mode';
                    });
                  },
                  child: ItemBackground(
                    backgroundSelected: background,
                    color: Colors.black,
                    background: AppLocalizations.of(context)!.darkMode,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      background = 'Light mode';
                    });
                  },
                  child: ItemBackground(
                    backgroundSelected: background,
                    color: Colors.white,
                    background: AppLocalizations.of(context)!.lightMode,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              'Beans',
              style: AppStyles.medium.copyWith(
                color: AppColors.textPrimaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: setting.myBeans
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
                        setState(() {
                          beanSelected = e;
                        });
                      },
                      child: ItemBean(
                        bean: e,
                        beanSelected: beanSelected,
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.appbarColor,
        child: Container(
          height: 80,
          padding: const EdgeInsets.all(10),
          child: SafeArea(
            child: AppButton(
              textButton: AppLocalizations.of(context)!.apply,
              style: AppStyles.semibold.copyWith(color: Colors.white),
              onTap: setTheme,
            ),
          ),
        ),
      ),
    );
  }
}
