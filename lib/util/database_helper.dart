import 'dart:async';

import 'package:flutter_app_not_to_do/model/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{
  static final DatabaseHelper _instance=new DatabaseHelper.internal();

  factory DatabaseHelper()=> _instance;

  static Database _db;

  Future<Database> get db async{
    if(_db!=null)
      return _db;

    _db=await initdb();
    return _db;
  }

  DatabaseHelper.internal();

  initdb() async{
    var directory=await getApplicationDocumentsDirectory();

    String path= join(directory.path,"maindb.db");
    var ourDb=await openDatabase(path,version: 1,onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async{
    await db.execute(
        "CREATE TABLE userTable(id INTEGER PRIMARY KEY,itemName TEXT,dateCreated TEXT)"
    );
  }

  Future<int> saveUser(User user) async{
    var dbClient=await db;
    var res=await dbClient.insert("userTable", user.toMap());
    return res;
  }

  Future<List> getAllUsers() async{
    var dbClient=await db;
    var result=await dbClient.rawQuery("SELECT * FROM userTable");
    return result.toList();
  }

  Future<int> getCount() async{
    var dbClient=await db;
    var result=await dbClient.rawQuery("SELECT COUNT(*) FROM userTable");
//    return int.parse(result);
  return int.parse(result.toList().toString());
  }

  Future<User> getUser(int id) async
  {
    var dbClient=await db;
    List<Map> result=await dbClient.rawQuery("SELECT * FROM userTable WHERE id=$id");

    return new User.fromMap(result.first);
  }
  Future<int> deleteUser(int id) async{
    var dbClient=await db;
    return await dbClient.delete("userTable",where: "id=?",whereArgs: [id]);
//    return await dbClient.rawQuery("DELETE FROM userTable WHERE itemName=$itemName");
//    return int.parse(result.toList().toString());
  }

}