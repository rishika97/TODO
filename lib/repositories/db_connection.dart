import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseConnection{

  setDatabase() async{
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_todo');
    var database = await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database db, int version)async{
    await db.execute("CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT, description TEXT)");
  }
}