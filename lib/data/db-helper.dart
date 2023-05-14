import 'dart:developer';
import 'package:hw_quizapp/data%20model/data-model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static DbHelper dbHelper = DbHelper();
  DbHelper() {
    initDatabase();
  }

  static const String tableName = 'models';
  static const String quesIdColumName = 'id';
  static const String questionColumName = 'queName';
  static const String answAColumName = 'ansA';
  static const String answBColumName = 'ansB';
  static const String answCColumName = 'ansC';
  static const String answDColumName = 'ansD';
  static const String corrAnswColumName = 'correctAns';

  Database? database;

  initDatabase() async {
    database = await createConnectionWithDatabase();
  }

  Future<Database> createConnectionWithDatabase() async {
    String databasePath = await getDatabasesPath();
    String databaseName = 'models.db';
    String fullPath = join(databasePath, databaseName);
    Database database =
        await openDatabase(fullPath, version: 1, onCreate: (db, i) {
      log('hello, the database has been created');
      db.execute('''
 CREATE TABLE $tableName (
 $quesIdColumName INTEGER PRIMARY KEY AUTOINCREMENT,
 $questionColumName TEXT, 
 $answAColumName TEXT, 
 $answBColumName TEXT, 
 $answCColumName TEXT, 
 $answDColumName TEXT, 
 $corrAnswColumName TEXT)
''');
    }, onOpen: (db) async {
      final tables =
          await db.rawQuery('SELECT name FROM sqlite_master ORDER BY name;');
      log(tables.toString());
    });
    return database;
  }

  insertData(Model model) async {
    int rowIndex = await database!.insert(tableName, model.toMap());
    log(rowIndex.toString());
  }

  Future<List<Model>> selectData() async {
    List<Map<String, Object?>> rowsAsMaps = await database!.query(tableName);
    List<Model> quesData = rowsAsMaps.map((e) => Model.fromMap(e)).toList();
    return quesData;
  }

  deleteOneQuestion(int id) {
    database!.delete(tableName, where: '$quesIdColumName=?', whereArgs: [id]);
  }
}
