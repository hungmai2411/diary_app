import 'package:diary_app/features/setting/models/setting.dart';
import 'package:diary_app/services/db_helpers.dart';
import 'package:flutter/foundation.dart';

class SettingProvider extends ChangeNotifier {
  Setting _setting = Setting();
  final DbHelper dbHelper = DbHelper();

  Setting get setting => _setting;

  void setSetting(Setting setting) async {
    final box = await dbHelper.openBox("settings");

    dbHelper.addSetting(box, setting);
    _setting = setting;
    notifyListeners();
  }
}
