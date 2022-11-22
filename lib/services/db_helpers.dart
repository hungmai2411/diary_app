import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> database(String table) async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      '${dbPath}diary.db',
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE $table(id INTEGER PRIMARY KEY AUTOINCREMENT, createdAt TEXT, mood TEXT, imageMood TEXT,content TEXT,)');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database(table);
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database(table);
    var res = await db.rawQuery("SELECT * FROM $table");
    return res.toList();
  }

  static Future<void> delete(String datetime, String table) async {
    final db = await DBHelper.database(table);
    await db.rawDelete('DELETE FROM user_moods WHERE datetime = ?', [datetime]);
  }
}
