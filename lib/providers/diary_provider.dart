import 'package:diary_app/features/diary/models/diary.dart';
import 'package:diary_app/features/diary/models/mood.dart';
import 'package:diary_app/services/db_helpers.dart';
import 'package:flutter/foundation.dart';
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

    Diary newDiary = await dbHelper.addDiary(box, diary);

    _diaries.add(newDiary);
    notifyListeners();
  }

  void deleteDiary(Diary diary) async {
    final box = await dbHelper.openBox("diaries");
    await dbHelper.deleteDiary(box, diary.key!);

    _diaries.remove(diary);
    notifyListeners();
  }

  void editDiary(
    Diary diary,
    Mood mood,
    String? content,
    List<Uint8List>? images,
  ) async {
    for (var d in _diaries) {
      if (diary.key == d.key) {
        _diaries.remove(d);
        break;
      }
    }

    final box = await dbHelper.openBox("diaries");

    diary = diary.copyWith(
      mood: mood,
      content: content,
      images: images,
    );
    _diaries.add(diary);
    await dbHelper.editDiary(box, diary.key!, diary);

    notifyListeners();
  }
}
