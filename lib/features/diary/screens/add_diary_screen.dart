import 'dart:typed_data';
import 'package:diary_app/constants/app_assets.dart';
import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/features/diary/models/diary.dart';
import 'package:diary_app/features/diary/models/mood.dart';
import 'package:diary_app/features/diary/widgets/item_mood.dart';
import 'package:diary_app/features/diary/widgets/item_upload_group.dart';
import 'package:diary_app/features/diary/widgets/item_upload_voice.dart';
import 'package:diary_app/providers/diary_provider.dart';
import 'package:diary_app/widgets/box.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

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

  addNote(BuildContext context) {
    if (moodPicked.name.isEmpty) {
    } else {
      final diaryProvider = context.read<DiaryProvider>();
      Diary newDiary = Diary(
        mood: moodPicked,
        createdAt: widget.dateTime,
        content: noteController.text,
        images: images,
      );
      diaryProvider.addDiary(newDiary);
      popScreen();
    }
  }

  @override
  void dispose() {
    super.dispose();
    noteController.dispose();
  }

  final List moods = [
    Mood(name: 'Angry', image: AppAssets.iconAngry),
    Mood(name: 'Loving', image: AppAssets.iconLoving),
    Mood(name: 'Sad', image: AppAssets.iconSad),
    Mood(name: 'Scared', image: AppAssets.iconScared),
    Mood(name: 'Smile', image: AppAssets.iconSmile),
    Mood(name: 'Surprised', image: AppAssets.iconSurprised),
    Mood(name: 'Sleeping', image: AppAssets.iconSleeping),
  ];

  @override
  Widget build(BuildContext context) {
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
          DateFormat('MMM d, yyyy').format(widget.dateTime),
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
          // Padding(
          //   padding: EdgeInsets.only(right: 8.0),
          //   child: Icon(
          //     FontAwesomeIcons.trashCan,
          //     size: 20,
          //     color: AppColors.textPrimaryColor,
          //   ),
          // ),
        ],
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // how was your day ?
          Box(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How was your day?',
                  style: AppStyles.medium.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
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
                Text(
                  'Write about today',
                  style: AppStyles.medium.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 5),
                const Divider(
                  color: AppColors.textSecondaryColor,
                ),
                SizedBox(
                  height: 150,
                  child: TextField(
                    scrollPadding: EdgeInsets.zero,
                    controller: noteController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Write something...',
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
                  'Your photos',
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
    );
  }
}
