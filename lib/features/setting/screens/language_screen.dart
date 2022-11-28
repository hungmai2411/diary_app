import 'package:diary_app/constants/app_assets.dart';
import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/features/setting/models/language.dart';
import 'package:diary_app/features/setting/models/setting.dart';
import 'package:diary_app/providers/setting_provider.dart';
import 'package:diary_app/widgets/box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});
  static const String routeName = '/language_screen';

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final List languages = [
    Language(AppAssets.iconEnglish, 'English'),
    Language(AppAssets.iconVietnamese, 'Tiếng Việt'),
  ];

  chooseLanguage(Language language) {
    final settingProvider = context.read<SettingProvider>();
    Setting setting = settingProvider.setting;
    setting = setting.copyWith(language: language.language);
    settingProvider.setSetting(setting);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final settingProvider = context.read<SettingProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.textPrimaryColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Start day of the week',
          style: AppStyles.regular.copyWith(fontSize: 16),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          Language language = languages[index];

          return GestureDetector(
            onTap: () => chooseLanguage(language),
            child: Box(
              margin: const EdgeInsets.only(
                bottom: 10.0,
                left: 20,
                right: 20,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              child: Row(
                children: [
                  Image.asset(
                    language.img,
                    fit: BoxFit.cover,
                    width: 40,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    language.language,
                    style: AppStyles.medium.copyWith(
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  settingProvider.setting.language == language.language
                      ? Icon(
                          Icons.check,
                          color: AppColors.selectedColor,
                        )
                      : const SizedBox()
                ],
              ),
            ),
          );
        },
        itemCount: languages.length,
      ),
    );
  }
}
