import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConnection {
  Future setDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todo.db');
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database db, int version) async {
    await db.execute(
        'CREATE TABLE categories (id INTEGER PRIMARY KEY, name TEXT, description TEXT)');
  }
}
