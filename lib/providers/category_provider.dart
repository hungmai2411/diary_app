import 'package:diary_app/services/db_helpers.dart';
import 'package:flutter/material.dart';

import '../features/category/models/category.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> _categories = [];
  List<Category> get categories => _categories;
  final DbHelper dbHelper = DbHelper();

  void setCategories(List<Category> categories) {
    _categories = categories;
    notifyListeners();
  }

  void addCategory(Category category) async {
    final box = await dbHelper.openBox("categories");

    Category categoryNew = await dbHelper.addCategory(box, category);
    _categories.add(categoryNew);
    notifyListeners();
  }

  // void deleteDiary(Diary diary) async {
  //   final box = await dbHelper.openBox("diaries");
  //   await dbHelper.deleteDiary(box, diary.key!);

  //   _diaries.remove(diary);
  //   notifyListeners();
  // }

  // void editDiary(
  //   Diary diary,
  //   Mood mood,
  //   String? content,
  //   List<Uint8List>? images,
  // ) async {
  //   for (var d in _diaries) {
  //     if (diary.key == d.key) {
  //       _diaries.remove(d);
  //       break;
  //     }
  //   }

  //   final box = await dbHelper.openBox("diaries");

  //   diary = diary.copyWith(
  //     mood: mood,
  //     content: content,
  //     images: images,
  //   );
  //   _diaries.add(diary);
  //   await dbHelper.editDiary(box, diary.key!, diary);

  //   notifyListeners();
  // }
}
