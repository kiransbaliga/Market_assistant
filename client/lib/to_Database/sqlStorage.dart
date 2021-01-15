import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// import './main.dart';

Database database;
Future<void> openLocalStorage() async {
  database = await openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'markus.db'),
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      db.execute(
        "CREATE TABLE IF NOT EXISTS markustable (id INTEGER PRIMARY KEY, token TEXT, user_id TEXT,name TEXT,email TEXT,username TEXT)",
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );
}

bool isdatabaseopen() {
  if (database == null)
    return false;
  else
    return database.isOpen;
}

void closedb() async {
  await database.close();
}

Future<void> login(String token, String userid, String name, String email,
    String username) async {
  final Database db = database;
  await db.delete('markustable');
  await db.insert(
    'markustable',
    {
      'token': token,
      'user_id': userid,
      'name': name,
      'email': email,
      'username': username
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<void> deleteEvent() async {
  final Database db = database;

  await db.delete('markustable');
}

Future<List<Map>> getfromsql() async {
  // Get a reference to the database.
  final Database db = database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('markustable');
  return maps;
}
