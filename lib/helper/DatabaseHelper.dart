import 'package:path/path.dart';
import 'package:salvadanaio/model/Transazione.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {
  //Create a private constructor
  DatabaseHelper._();

  static const databaseNameTransazioni = 'transazioni_database.db';

  static final DatabaseHelper instance = DatabaseHelper._();
  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      return await initializeDatabaseTransazioni();
    }
    return _database;
  }

/*
  initializeDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), databaseName),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, content TEXT)");
    });
  }
*/

  initializeDatabaseTransazioni() async {
    return await openDatabase(join(await getDatabasesPath(), databaseNameTransazioni),
        version: 1, onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE transazioni(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, descrizione TEXT, totale DOUBLE, data String)");
        });
  }

  insertTransazione(Transazione t) async {
    final db = await database;
    var res = await db.insert(Transazione.TABLENAME, t.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

/*
  insertTodo(Todo todo) async {
    final db = await database;
    var res = await db.insert(Todo.TABLENAME, todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }
*/

  Future<List<Transazione>> retriveTransazioni() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(Transazione.TABLENAME);

    return List.generate(maps.length, (i) {
      return Transazione(
        id: maps[i]['id'],
        totale: maps[i]['totale'],
        desrizione: maps[i]['descrizione'],
        dateTime: maps[i]['data']
      );
    });
  }

/*
  Future<List<Todo>> retrieveTodos() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(Todo.TABLENAME);

    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        title: maps[i]['title'],
        content: maps[i]['content'],
      );
    });
  }
*/


  updateTransazione(Transazione t) async {
    final db = await database;

    await db.update(Transazione.TABLENAME, t.toMap(),
        where: 'id = ?',
        whereArgs: [t.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  deleteTransazione(int id) async {
    var db = await database;
    db.delete(Transazione.TABLENAME, where: 'id = ?', whereArgs: [id]);
  }


/*  updateTodo(Todo todo) async {
    final db = await database;

    await db.update(Todo.TABLENAME, todo.toMap(),
        where: 'id = ?',
        whereArgs: [todo.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  deleteTodo(int id) async {
    var db = await database;
    db.delete(Todo.TABLENAME, where: 'id = ?', whereArgs: [id]);
  }*/
}
