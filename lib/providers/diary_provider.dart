import 'package:diary_app/features/diary/models/diary.dart';
import 'package:diary_app/services/db_helpers.dart';
import 'package:flutter/material.dart';

class DiaryProvider extends ChangeNotifier {
  List<Diary> _diaries = [];
  List<Diary> get diaries => _diaries;
  final DbHelper dbHelper = DbHelper();

  void setDiaries(List<Diary> diaries) {
    print(diaries);
    _diaries = diaries;
    notifyListeners();
  }

  void addDiary(Diary diary) async {
    final box = await dbHelper.openBox("diaries");

    dbHelper.addDiary(box, diary);

    _diaries.add(diary);
    notifyListeners();
  }
}
