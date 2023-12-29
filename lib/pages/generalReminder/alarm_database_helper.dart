import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const tableName = "alarmT";
const columnId = "id";
const columntext = "text";
const columntextdesc = "textdesc";
const columnDateTime  ="datetime";
class Alarm {
  int id;
  DateTime dateTime;
  String text;
  String textdesc;

  Alarm({this.id=0,required this.dateTime, required this.text,required this.textdesc});

  // Add methods or additional properties as needed

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateTime': dateTime.toIso8601String(),
      'text': text,
      'textdesc' : textdesc,
    };
  }
}
class AlarmHelper{
  static Database? _database;

  Future<void> initializeDatabase() async {

    _database ??= await openDatabase(
      
      join(await getDatabasesPath(), "alarms.db"),
      version: 1,
      onCreate: (db, version) async {
        
          await db.execute('''
            CREATE TABLE  $tableName(
              $columnId INTEGER primary key autoincrement,
              $columnDateTime TEXT not null,
              $columntext TEXT not null,
              $columntextdesc TEXT
            );
          ''');
          
      
      },
    ); 
    return ;
  

  }

  Future<void> insertAlarm(Alarm alarm) async {
    if (_database == null) {

      return;
    }

    await _database!.insert(
      tableName,//Adds to the table;
      alarm.toMap(),//while adding objects to the database need Maps, key-value pairs
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Alarm>> getAlarms() async {
    if (_database == null) {
      return [];
    }

    final List<Map<String, dynamic>> maps = await _database!.query(tableName); // Retrieves every row in the table

  //Iterates through all of the row[maps] and the accesses the values through column names

  //This creates List of ALarm objects
  //Which is sent to whoever called for the whole list in the table!
  //This is sent to alarms[] which is genApp 
  //This then iterates through all of the objects then takes data out of it and converts it to some UI
  //UI as in the box which stores reminder name, reminder description, Date and time

    return List.generate(maps.length, (i) {
      return Alarm(
        id: maps[i]['id'],
        dateTime: DateTime.parse(maps[i]['datetime'] ?? '2023-01-01T00:00:00Z'),
        text: maps[i]['text'],
        textdesc: maps[i]['textdesc'],
      );
    });
  }
  Future<void> deleteAlarm(int id) async {
    Database? db = _database;
    if(db!=null){
    await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
    }
    
  }
  Future<int> getMostRecentValue() async {
  Database? db = _database;

  // Execute the query
  List<Map<String, dynamic>> result = await db!.query(
    tableName,
    orderBy: "id ASC", // Order by the column in descending order // Limit the result to 1 row
  );

  // Check if there's a result
  if (result.isNotEmpty) {
    // Access the value from the most recent row
    int mostRecentValue = result.last['id'];
    return mostRecentValue;
  } else {
    // Handle the case where there are no rows in the table
    return 0; // or any default value that makes sense for your use case
  }
}
}