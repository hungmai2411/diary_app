import 'dart:convert';
import 'dart:typed_data';
import 'package:diary_app/constants/app_assets.dart';
import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/constants/utils.dart';
import 'package:diary_app/features/diary/models/diary.dart';
import 'package:diary_app/features/diary/models/mood.dart';
import 'package:diary_app/features/diary/widgets/item_mood.dart';
import 'package:diary_app/features/diary/widgets/item_upload_group.dart';
import 'package:diary_app/features/setting/models/setting.dart';
import 'package:diary_app/my_app.dart';
import 'package:diary_app/providers/diary_provider.dart';
import 'package:diary_app/providers/setting_provider.dart';
import 'package:diary_app/widgets/box.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  quill.QuillController noteController = quill.QuillController.basic();
  final FocusNode editorFocusNode = FocusNode();

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
        jsonEncode(noteController.document.toDelta().toJson()),
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
    getMoods();

    if (widget.diary.content != null) {
      var json = jsonDecode(widget.diary.content!);
      noteController = quill.QuillController(
        document: quill.Document.fromJson(json),
        selection: const TextSelection.collapsed(offset: 0),
      );
    }
    moodPicked = widget.diary.mood;
    if (widget.diary.images != null) {
      images = widget.diary.images!;
    }
  }

  late final List moods;
  getMoods() {
    final SettingProvider settingProvider = context.read<SettingProvider>();
    Setting setting = settingProvider.setting;
    String nameBean = setting.bean.nameBean;

    if (nameBean == 'Basic Bean') {
      moods = [
        Mood(name: 'Mood1', image: basicBean[0]),
        Mood(name: 'Mood2', image: basicBean[1]),
        Mood(name: 'Mood3', image: basicBean[2]),
        Mood(name: 'Mood4', image: basicBean[3]),
        Mood(name: 'Mood5', image: basicBean[4]),
      ];
    } else if (nameBean == 'Blushing Bean') {
      moods = [
        Mood(name: 'Mood1', image: blushingBean[0]),
        Mood(name: 'Mood2', image: blushingBean[1]),
        Mood(name: 'Mood3', image: blushingBean[2]),
        Mood(name: 'Mood4', image: blushingBean[3]),
        Mood(name: 'Mood5', image: blushingBean[4]),
      ];
    } else if (nameBean == 'Kitty Bean') {
      moods = [
        Mood(name: 'Mood1', image: kittyBean[0]),
        Mood(name: 'Mood2', image: kittyBean[1]),
        Mood(name: 'Mood3', image: kittyBean[2]),
        Mood(name: 'Mood4', image: kittyBean[3]),
        Mood(name: 'Mood5', image: kittyBean[4]),
      ];
    } else {
      moods = [
        Mood(name: 'Mood1', image: sproutBean[0]),
        Mood(name: 'Mood2', image: sproutBean[1]),
        Mood(name: 'Mood3', image: sproutBean[2]),
        Mood(name: 'Mood4', image: sproutBean[3]),
        Mood(name: 'Mood5', image: sproutBean[4]),
      ];
    }
  }

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
                    // child: TextField(
                    //   maxLines: null,
                    //   keyboardType: TextInputType.multiline,
                    //   autocorrect: false,
                    //   scrollPadding: EdgeInsets.zero,
                    //   controller: noteController,
                    //   decoration: InputDecoration(
                    //     border: InputBorder.none,
                    //     contentPadding: EdgeInsets.zero,
                    //     hintText: 'Write something...',
                    //     hintStyle: AppStyles.regular.copyWith(
                    //       fontSize: 17,
                    //       color: AppColors.textSecondColor,
                    //     ),
                    //   ),
                    // ),
                    child: quill.QuillEditor(
                      scrollable: true,
                      scrollController: ScrollController(),
                      focusNode: editorFocusNode,
                      padding: const EdgeInsets.all(0),
                      autoFocus: true,
                      readOnly: false,
                      expands: false,
                      controller: noteController,
                      placeholder: AppLocalizations.of(context)!.writeSomething,
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
