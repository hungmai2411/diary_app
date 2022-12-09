import 'package:carousel_slider/carousel_slider.dart';
import 'package:diary_app/constants/app_assets.dart';
import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/constants/bean.dart';
import 'package:diary_app/features/setting/models/setting.dart';
import 'package:diary_app/features/setting/widgets/item_carousel.dart';
import 'package:diary_app/providers/setting_provider.dart';
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

  @override
  void initState() {
    super.initState();
    settingProvider = context.read<SettingProvider>();
    setting = settingProvider.setting;
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

  setTheme(String img) {
    if (img == AppAssets.imgBasicBean) {
      setting = setting.copyWith(
        bean: const Bean(
          nameBean: 'Basic Bean',
          beans: basicBean,
        ),
      );
    } else if (img == AppAssets.imgBlushBean) {
      setting = setting.copyWith(
        bean: const Bean(
          nameBean: 'Blush Bean',
          beans: blushingBean,
        ),
      );
    } else if (img == AppAssets.imgKittyBean) {
      setting = setting.copyWith(
        bean: const Bean(
          nameBean: 'Kitty Bean',
          beans: kittyBean,
        ),
      );
    } else {
      setting = setting.copyWith(
        bean: const Bean(
          nameBean: 'Sprout Bean',
          beans: sproutBean,
        ),
      );
    }

    settingProvider.setSetting(setting);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      AppAssets.imgBasicBean,
      AppAssets.imgBlushBean,
      AppAssets.imgKittyBean,
      AppAssets.imgSproutBean,
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          AppLocalizations.of(context)!.changeTheme,
          style: AppStyles.semibold.copyWith(fontSize: 18),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.textPrimaryColor,
          ),
        ),
      ),
      body: SizedBox(
        height: 600,
        width: double.infinity,
        child: CarouselSlider(
          carouselController: controller,
          options: CarouselOptions(
            initialPage: getInitialPage(),
            autoPlay: false,
            viewportFraction: 0.623,
            aspectRatio: 0.6,
            enlargeCenterPage: true,
          ),
          items: images
              .map(
                (e) => GestureDetector(
                  onTap: () => setTheme(e),
                  child: ItemCarousel(image: e),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
