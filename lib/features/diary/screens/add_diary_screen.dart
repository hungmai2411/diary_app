import 'dart:typed_data';
import 'package:diary_app/constants/app_assets.dart';
import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/constants/utils.dart';
import 'package:diary_app/features/diary/models/diary.dart';
import 'package:diary_app/features/diary/models/mood.dart';
import 'package:diary_app/features/diary/screens/document_screen.dart';
import 'package:diary_app/features/diary/widgets/item_mood.dart';
import 'package:diary_app/features/diary/widgets/item_upload_group.dart';
import 'package:diary_app/features/diary/widgets/success_dialog.dart';
import 'package:diary_app/features/setting/models/setting.dart';
import 'package:diary_app/providers/diary_provider.dart';
import 'package:diary_app/providers/setting_provider.dart';
import 'package:diary_app/widgets/box.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddDiaryScreen extends StatefulWidget {
  final DateTime dateTime;

  const AddDiaryScreen({
    super.key,
    required this.dateTime,
  });
  static const String routeName = '/add_diary_screen';
  @override
  State<AddDiaryScreen> createState() => _AddDiaryScreenState();
}

class _AddDiaryScreenState extends State<AddDiaryScreen> {
  Mood moodPicked = Mood(name: '', image: '');
  final TextEditingController noteController = TextEditingController();
  // lưu trữ hình ảnh
  List<Uint8List> images = [];

  popScreen() {
    Navigator.pop(context);
  }

  addNote(BuildContext context) async {
    if (moodPicked.name.isEmpty) {
      showSnackBar(
        context,
        AppLocalizations.of(context)!.pleaseRecordYourMood,
      );
    } else {
      final SettingProvider settingProvider = context.read<SettingProvider>();
      Setting setting = settingProvider.setting;
      setting = setting.copyWith(point: setting.point + 100);
      settingProvider.setSetting(setting);
      final diaryProvider = context.read<DiaryProvider>();
      Diary newDiary = Diary(
        mood: moodPicked,
        createdAt: widget.dateTime,
        content: noteController.text.isEmpty ? null : noteController.text,
        images: images,
      );
      diaryProvider.addDiary(newDiary);
      await showDialog(
        context: context,
        builder: (_) {
          return const SuccessDialog();
        },
      );
      popScreen();
    }
  }

  @override
  void dispose() {
    super.dispose();
    noteController.dispose();
  }

  final List moods = [
    Mood(name: 'Mood1', image: AppAssets.iconMood1),
    Mood(name: 'Mood2', image: AppAssets.iconMood2),
    Mood(name: 'Mood3', image: AppAssets.iconMood3),
    Mood(name: 'Mood4', image: AppAssets.iconMood4),
    Mood(name: 'Mood5', image: AppAssets.iconMood5),
  ];

  @override
  Widget build(BuildContext context) {
    final SettingProvider settingProvider = context.read<SettingProvider>();

    Setting setting = settingProvider.setting;
    String locale = setting.language == 'English' ? 'en' : 'vi';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: popScreen,
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.textPrimaryColor,
          ),
        ),
        title: Text(
          DateFormat('MMM d, yyyy', locale).format(widget.dateTime),
          style: AppStyles.medium.copyWith(fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () => addNote(context),
              child: const Icon(
                FontAwesomeIcons.check,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          children: [
            // how was your day ?
            Box(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, right: 15, top: 10),
                    child: Text(
                      AppLocalizations.of(context)!.howWasYourDay,
                      style: AppStyles.medium.copyWith(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: moods
                        .map(
                          (e) => ItemMood(
                            mood: e,
                            isPicked: moodPicked.name == (e as Mood).name
                                ? true
                                : false,
                            callback: (mood) {
                              setState(() {
                                moodPicked = mood;
                              });
                            },
                          ),
                        )
                        .toList(),
                  )
                ],
              ),
            ),
            // write about to day
            Box(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.writeAboutToday,
                        style: AppStyles.medium.copyWith(fontSize: 18),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () async {
                          final result =
                              await Navigator.of(context).pushNamed<String>(
                            DocumentScreen.routeName,
                          );

                          setState(() {
                            noteController.text = result!;
                          });
                        },
                        child: const FaIcon(
                          FontAwesomeIcons.upRightAndDownLeftFromCenter,
                          color: AppColors.textPrimaryColor,
                          size: 17,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Divider(
                    color: AppColors.textSecondaryColor,
                  ),
                  SizedBox(
                    height: 150,
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      autocorrect: false,
                      scrollPadding: EdgeInsets.zero,
                      controller: noteController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        hintText: AppLocalizations.of(context)!.writeSomething,
                        hintStyle: AppStyles.regular.copyWith(
                          fontSize: 17,
                          color: AppColors.textSecondColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // your photos
            Box(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.yourPhotos,
                    style: AppStyles.medium.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  ItemUploadGroup(
                    images: images,
                  ),
                ],
              ),
            ),
            // your voices
            // Box(
            //   margin: const EdgeInsets.symmetric(
            //     horizontal: 20,
            //     vertical: 10,
            //   ),
            //   child: ItemUploadVoice(),
            // ),
          ],
        ),
      ),
    );
  }
}
