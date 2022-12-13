import 'package:diary_app/constants/app_assets.dart';
import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/constants/bean.dart';
import 'package:diary_app/features/setting/models/setting.dart';
import 'package:diary_app/features/setting/widgets/item_theme_store.dart';
import 'package:diary_app/providers/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ThemeStoreScreen extends StatelessWidget {
  const ThemeStoreScreen({super.key});
  static const String routeName = '/theme_store_screen';
  @override
  Widget build(BuildContext context) {
    List<Bean> beans = const [
      Bean(nameBean: 'Kitty Bean', beans: kittyBean),
      Bean(nameBean: 'Sprout Bean', beans: sproutBean),
      Bean(nameBean: 'Blush Bean', beans: blushingBean),
    ];

    List<int> coins = [
      1000,
      500,
      200,
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appbarColor,
        elevation: 0.3,
        automaticallyImplyLeading: false,
        title: Text(
          AppLocalizations.of(context)!.themeStore,
          style: AppStyles.medium.copyWith(fontSize: 18),
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
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          Bean bean = beans[index];

          return ItemThemeStore(
            bean: bean,
            coin: coins[index],
          );
        },
        itemCount: beans.length,
      ),
    );
  }
}
