import 'dart:developer';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/models/todo_model.dart';

class ToDoDbHelper {
  ToDoDbHelper._();
  static final ToDoDbHelper toDoDbHelper = ToDoDbHelper._();
  Database? db;
  initDB() async {
    String dataBasePath = await getDatabasesPath();

    String path = join(dataBasePath, 'todo.db');

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE todo(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT NOT NULL,done INTEGER NOT NULL);";

        db.execute(query);
      },
    );
  }

  Future<int> addToDO(ToDoModel toDo) async {
    await initDB();

    String query = "INSERT INTO todo(name,done) VALUES(?,?)";
    List args = [
      toDo.name,
      toDo.done,
    ];

    return db!.rawInsert(query, args);
  }

  Future<List<ToDoModel>> fetchToDos() async {
    await initDB();

    String query = "SELECT * FROM todo;";

    List<Map<String, Object?>> allRecord = await db!.rawQuery(query);

    List<ToDoModel> allRecordModel = allRecord.map((e) {
      return ToDoModel.fromMap(
        data: e,
      );
    }).toList();
    log(allRecordModel[0].name);
    return allRecordModel;
  }

  deleteToDoById(int id) async {
    await initDB();

    String query = "DELETE FROM toDo WHERE id=?";
    List args = [id];

    db!.rawDelete(query, args);
  }

  Future<int> editToDo(int id, String newName) async {
    await initDB();

    String query = "UPDATE toDo SET name = ? WHERE id = ?";

    List args = [newName, id];

    return db!.rawUpdate(query, args);
  }

}