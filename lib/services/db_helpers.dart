import 'package:diary_app/features/diary/models/diary.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DbHelper {
  Future<Box> openBox(String boxName) async {
    Box box = await Hive.openBox<Diary>(boxName);
    return box;
  }

  List<Diary> getDiaries(Box box) => box.values.toList().cast<Diary>();

  Future<void> addDiary(Box box, Diary diary) async => await box.add(diary);
}
