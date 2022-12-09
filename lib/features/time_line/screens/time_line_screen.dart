import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/constants/bean.dart';
import 'package:diary_app/features/diary/models/diary.dart';
import 'package:diary_app/features/diary/models/mood.dart';
import 'package:diary_app/features/diary/widgets/item_diary.dart';
import 'package:diary_app/features/diary/widgets/item_no_diary.dart';
import 'package:diary_app/features/setting/models/setting.dart';
import 'package:diary_app/providers/diary_provider.dart';
import 'package:diary_app/providers/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../constants/app_colors.dart';

class TimeLineScreen extends StatefulWidget {
  final List<Diary> diariesMonth;

  const TimeLineScreen({
    super.key,
    required this.diariesMonth,
  });
  static const String routeName = '/time_line_screen';
  @override
  State<TimeLineScreen> createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {
  bool isSort = false;
  late List<Diary> diaries;

  @override
  void initState() {
    super.initState();
    diaries = widget.diariesMonth;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColors.textPrimaryColor,
            ),
          ),
          automaticallyImplyLeading: false,
          title: Text(
            AppLocalizations.of(context)!.timeLineTab,
            style: AppStyles.semibold.copyWith(fontSize: 18),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (isSort) {
                    diaries.sort((a, b) => a.createdAt.compareTo(b.createdAt));
                  } else {
                    diaries.sort((b, a) => a.createdAt.compareTo(b.createdAt));
                  }
                  isSort = !isSort;
                });
              },
              icon: const Icon(
                Icons.sort,
                color: AppColors.textPrimaryColor,
              ),
            ),
          ]),
      body: diaries.isEmpty
          ? const SizedBox(
              width: double.infinity,
              child: ItemNoDiary(),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                Diary diary = diaries[index];
                return ItemDiary(diary: diary);
              },
              itemCount: diaries.length,
            ),
    );
  }
}
