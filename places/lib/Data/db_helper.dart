import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> _GetDataBase() async {
    final Path = await sql.getDatabasesPath();
    final dbPath = path.join(Path, 'places.db');

    //openDatabase will create db if it doesn't exist
    return await sql.openDatabase(
      dbPath,
      onCreate: (db, version) {
        var query =
            'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)';
        return db.execute(query);
      },
      version: 1,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await _GetDataBase();
    return db.query(table);
  }

  static Future<void> insertData(String table, Map<String, Object> data) async {
    final db = await _GetDataBase();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }
}
