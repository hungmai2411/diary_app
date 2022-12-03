import 'dart:typed_data';
import 'package:diary_app/constants/app_assets.dart';
import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/constants/utils.dart';
import 'package:diary_app/features/diary/models/diary.dart';
import 'package:diary_app/features/diary/models/mood.dart';
import 'package:diary_app/features/diary/screens/add_diary_screen.dart';
import 'package:diary_app/features/diary/screens/diary_screen.dart';
import 'package:diary_app/features/diary/widgets/item_mood.dart';
import 'package:diary_app/features/diary/widgets/item_upload_group.dart';
import 'package:diary_app/features/diary/widgets/success_dialog.dart';
import 'package:diary_app/features/setting/models/setting.dart';
import 'package:diary_app/my_app.dart';
import 'package:diary_app/providers/diary_provider.dart';
import 'package:diary_app/providers/setting_provider.dart';
import 'package:diary_app/widgets/box.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditDiaryScreen extends StatefulWidget {
  final Diary diary;

  const EditDiaryScreen({
    super.key,
    required this.diary,
  });
  static const String routeName = '/edit_diary_screen';
  @override
  State<EditDiaryScreen> createState() => _EditDiaryScreenState();
}

class _EditDiaryScreenState extends State<EditDiaryScreen> {
  Mood moodPicked = Mood(name: '', image: '');
  final TextEditingController noteController = TextEditingController();
  // lưu trữ hình ảnh
  List<Uint8List> images = [];

  popScreen() {
    Navigator.pop(context);
  }

  addNote(BuildContext context) async {
    if (moodPicked.name.isEmpty) {
      showSnackBar(context, 'Please record your mood');
    } else {
      final diaryProvider = context.read<DiaryProvider>();

      diaryProvider.editDiary(
        widget.diary,
        moodPicked,
        noteController.text,
        images,
      );

      Navigator.pushNamed(context, MyApp.routeName);
    }
  }

  @override
  void dispose() {
    super.dispose();
    noteController.dispose();
  }

  @override
  void initState() {
    super.initState();
    noteController.text = widget.diary.content!;
    moodPicked = widget.diary.mood;
    if (widget.diary.images != null) {
      images = widget.diary.images!;
    }
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
          DateFormat('MMM d, yyyy').format(widget.diary.createdAt),
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
                      'How was your day?',
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
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      autocorrect: false,
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
          ],
        ),
      ),
    );
  }
}
