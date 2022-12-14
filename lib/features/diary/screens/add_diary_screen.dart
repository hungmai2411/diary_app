import 'dart:convert';
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
import 'package:diary_app/widgets/app_button.dart';
import 'package:diary_app/widgets/app_dialog.dart';
import 'package:diary_app/widgets/box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tuple/tuple.dart';

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
  //final TextEditingController noteController = TextEditingController();
  // lưu trữ hình ảnh
  List<Uint8List> images = [];
  final FocusNode editorFocusNode = FocusNode();

  quill.QuillController noteController = quill.QuillController.basic();

  popScreen() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
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
      var json = jsonEncode(noteController.document.toDelta().toJson());
      var note = noteController.document.toPlainText();
      print(note.length);
      Diary newDiary = Diary(
        mood: moodPicked,
        createdAt: widget.dateTime,
        content: note.length == 1 ? null : json,
        images: images,
      );
      diaryProvider.addDiary(newDiary);
      await showDialog(
        context: context,
        builder: (_) {
          return const AppDialog(child: SuccessDialog());
        },
      );
      popScreen();
    }
  }

  late final List moods;

  @override
  void initState() {
    super.initState();
    getMoods();
  }

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
    final SettingProvider settingProvider = context.read<SettingProvider>();

    Setting setting = settingProvider.setting;
    String locale = setting.language == 'English' ? 'en' : 'vi';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: popScreen,
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.textPrimaryColor,
          ),
        ),
        title: Text(
          DateFormat('MMM d, yyyy', locale).format(widget.dateTime),
          style: AppStyles.medium.copyWith(
            fontSize: 18,
            color: AppColors.textPrimaryColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () => addNote(context),
              child: Icon(
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
                      style: AppStyles.medium.copyWith(
                        fontSize: 18,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 80,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                      ),
                      itemCount: moods.length,
                      itemBuilder: (context, index) {
                        Mood mood = moods[index];
                        return ItemMood(
                          mood: mood,
                          isPicked: moodPicked.name == mood.name ? true : false,
                          callback: (mood) {
                            setState(() {
                              moodPicked = mood;
                            });
                          },
                        );
                      },
                    ),
                  ),
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
                        style: AppStyles.medium.copyWith(
                          fontSize: 18,
                          color: AppColors.textPrimaryColor,
                        ),
                      ),
                      const Spacer(),
                      // GestureDetector(
                      //   onTap: () async {
                      //     final result =
                      //         await Navigator.of(context).pushNamed<String>(
                      //       DocumentScreen.routeName,
                      //     );
                      //     var json = jsonDecode(result!);

                      //     setState(() {
                      //       noteController = quill.QuillController(
                      //         document: quill.Document.fromJson(json),
                      //         selection:
                      //             const TextSelection.collapsed(offset: 0),
                      //       );
                      //     });
                      //   },
                      //   child: FaIcon(
                      //     FontAwesomeIcons.upRightAndDownLeftFromCenter,
                      //     color: AppColors.textPrimaryColor,
                      //     size: 17,
                      //   ),
                      // )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Divider(
                    color: AppColors.textSecondaryColor,
                  ),
                  SizedBox(
                    height: 150,
                    child: quill.QuillEditor(
                      scrollable: true,
                      scrollController: ScrollController(),
                      focusNode: editorFocusNode,
                      padding: const EdgeInsets.all(0),
                      autoFocus: false,
                      readOnly: false,
                      expands: false,
                      controller: noteController,
                      placeholder: AppLocalizations.of(context)!.writeSomething,
                      customStyles: getDefaultStyles(context),
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
                    style: AppStyles.medium.copyWith(
                      fontSize: 18,
                      color: AppColors.textPrimaryColor,
                    ),
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
