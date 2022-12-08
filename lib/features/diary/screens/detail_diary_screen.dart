import 'package:diary_app/constants/app_assets.dart';
import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/features/diary/models/diary.dart';
import 'package:diary_app/features/diary/models/mood.dart';
import 'package:diary_app/features/diary/screens/edit_diary_screen.dart';
import 'package:diary_app/features/diary/widgets/delete_dialog.dart';
import 'package:diary_app/features/diary/widgets/image_group.dart';
import 'package:diary_app/features/diary/widgets/item_mood.dart';
import 'package:diary_app/widgets/box.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class DetailDiaryScreen extends StatelessWidget {
  final Diary diary;

  DetailDiaryScreen({
    super.key,
    required this.diary,
  });
  static const String routeName = '/detail_diary_screen';

  popScreen(BuildContext context) {
    Navigator.pop(context);
  }

  final List moods = [
    Mood(name: 'Mood1', image: AppAssets.iconBasicBean1),
    Mood(name: 'Mood2', image: AppAssets.iconBasicBean2),
    Mood(name: 'Mood3', image: AppAssets.iconBasicBean3),
    Mood(name: 'Mood4', image: AppAssets.iconBasicBean4),
    Mood(name: 'Mood5', image: AppAssets.iconBasicBean5),
  ];

  navigateToEditScreen(BuildContext context) {
    Navigator.pushNamed(
      context,
      EditDiaryScreen.routeName,
      arguments: diary,
    );
  }

  deleteDiary(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) {
        return DeleteDialog(
          diary: diary,
        );
      },
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => popScreen(context),
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.textPrimaryColor,
          ),
        ),
        title: Text(
          DateFormat('MMM d, yyyy').format(diary.createdAt),
          style: AppStyles.medium.copyWith(fontSize: 18),
        ),
        actions: [
          GestureDetector(
            onTap: () => navigateToEditScreen(context),
            child: const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                FontAwesomeIcons.penToSquare,
                size: 20,
                color: AppColors.textPrimaryColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => deleteDiary(context),
            child: const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                FontAwesomeIcons.trashCan,
                size: 20,
                color: AppColors.textPrimaryColor,
              ),
            ),
          ),
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
                          isPicked: diary.mood.name == (e as Mood).name
                              ? true
                              : false,
                          callback: (mood) {},
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
          // write about to day
          if (diary.content != null)
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
                    child: Text(
                      diary.content!,
                      style: AppStyles.regular.copyWith(
                        fontSize: 17,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          // your photos
          if (diary.images!.isNotEmpty)
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
                  Hero(
                    tag: diary.key!,
                    child: ImageGroup(images: diary.images!),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
