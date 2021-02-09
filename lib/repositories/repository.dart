import 'package:TODO/repositories/db_connection.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class Repository{
  DatabaseConnection _connection;

  Repository(){
    _connection = DatabaseConnection();
  }

  static Database _database;
  Future<Database> get database async{
    if(_database != null){
      return _database;
    }
    _database = await _connection.setDatabase();
    return _database;
  }

  save(table, data) async{
    var connection = await database;
    return await connection.insert(table, data);
  }

  getAll(table)async{
    return await _database.query(table);
  }
}