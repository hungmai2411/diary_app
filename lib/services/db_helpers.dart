import 'package:diary_app/features/diary/models/diary.dart';
import 'package:diary_app/features/setting/models/setting.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DbHelper {
  Future<Box> openBox(String boxName) async {
    Box box = await Hive.openBox(boxName);

    return box;
  }

  List<Diary> getDiaries(Box box) => box.values.toList().cast<Diary>();

  Future<Diary> addDiary(Box box, Diary diary) async {
    int key = await box.add(diary);
    diary = diary.copyWith(key: key);
    await box.delete(key);
    await box.put(key, diary);
    return diary;
  }

  Future<void> deleteDiary(Box box, int key) async => await box.delete(key);
  Future<void> editDiary(Box box, int key, Diary diary) async =>
      await box.put(key, diary);

  Future<void> addSetting(Box box, Setting setting) async =>
      await box.put('setting', setting);

  Setting getSetting(Box box) => box.get(
        'setting',
        defaultValue: Setting(),
      );
}
