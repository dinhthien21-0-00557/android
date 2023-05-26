import 'package:cuoiky/dao/db.dart';
import 'package:cuoiky/model/major.dart';
import 'package:sqflite/sqflite.dart';

class MajorDao {
  static const TABLE_NAME = 'majors';
  static const COL_ID = 'MAJ_ID';
  static const COL_NAME = 'Name';
  static String createTable() => '''
    CREATE TABLE IF NOT EXISTS $TABLE_NAME (
      $COL_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
      $COL_NAME TEXT
    );
  ''';
  Future<bool> insert(Major major) async {
    final db = await DB().open();

    final result = await db.insert(TABLE_NAME, _toMap(major),
        conflictAlgorithm: ConflictAlgorithm.replace);

    db.close();
    return result > 0;
  }

  Future<bool> update(Major major) async {
    final db = await DB().open();
    final result = await db.update(
      TABLE_NAME,
      _toMap(major),
      where: '$COL_ID = ?',
      whereArgs: [major.id],
    );
    db.close();
    return result > 0;
  }

  Future<Major?> get(int id) async {
    final db = await DB().open();
    var results = await db.query(
      TABLE_NAME,
      where: '$COL_ID = ?',
      whereArgs: [id],
      limit: 1,
    );
    db.close();
    return results.isEmpty ? null : _toMajor(results[0]);
  }

  Future<List<Major>> getMajors() async {
    final db = await DB().open();
    final results = await db.query(TABLE_NAME);
    db.close();
    return List.generate(results.length, (i) => _toMajor(results[i]));
  }

  Future<bool> delete(int id) async {
    final db = await DB().open();
    final result = await db.delete(
      TABLE_NAME,
      where: '$COL_ID = ?',
      whereArgs: [id],
    );
    db.close();
    return result > 0;
  }

  Map<String, dynamic> _toMap(Major major) {
    return {COL_NAME: major.username};
  }

  Major _toMajor(Map<String, dynamic> map) {
    return Major(
        id: map[COL_ID], username: map[COL_NAME], winlost: map[COL_NAME]);
  }
}
