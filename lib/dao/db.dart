import 'package:path/path.dart';
import 'major_dao.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static const DB_NAME = 'student_management.db';
  static const DB_VERSION = 1;
  Future<Database> open() async {
    final database = openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      version: DB_VERSION,
      onCreate: (db, version) async {
        await db.execute(MajorDao.createTable());
      },
    );
    return database;
  }
}
