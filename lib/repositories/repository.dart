import 'db_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository
{
  DatabaseConnection _connection;

  Repository()                                  //constructor
  {
    _connection = DatabaseConnection();

  }

  static Database _database;
  Future<Database> get database async{         //async method make a connection with .setDatabase
    if(_database != null)
    {
      return _database;
    }else{
     _database = await _connection.setDatabase();
     return _database;
    }
  }

  save(table, data) async{                               //async method to save first it call get database then it insert
    var conn = await database;
    return await conn.insert(table, data);
  }

  getAll(table) async
  {
    var conn = await database;
    return await conn.query(table);

  }

  getById(String table, itemId) async{
    var conn = await database;
    return await conn.query(table, where: 'id=?', whereArgs: [itemId]);

  }

    update(table, data) async{
    var conn = await database;
    return await conn.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  delete(table, categoryId) async{
    var conn = await database;
    return await conn.rawDelete("DELETE FROM $table WHERE id = $categoryId");
  }

  getByColumnName(String table, String columnName, String columnValue) async{
    var conn = await database;
    return await conn.query(table, where: '$columnName=?' , whereArgs: [columnValue]);
  }
  


}