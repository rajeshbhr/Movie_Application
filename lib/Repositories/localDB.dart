import 'package:flutter/foundation.dart';

import 'package:sqflite/sqflite.dart' as sql;

import '../Model/movie_model.dart';

class LocalDB {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        backdrop_path TEXT,
        poster_path TEXT,
        popularity DOUBLE,
        vote_average DOUBLE,
        release_date TEXT,
        isChecked BOOL,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'mitt.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(MovieModel movieModel) async {
    final db = await LocalDB.db();

    final data = {
      'id': movieModel.id,
      'title': movieModel.title,
      'overview': movieModel.overview,
      'backdrop_path': movieModel.backdropPath,
      'poster_path': movieModel.posterPath,
      'popularity': movieModel.popularity,
      'vote_average': movieModel.voteAverage,
      'release_date': movieModel.releaseDate,
      'isChecked': true,
    };
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await LocalDB.db();
    return db.query('items', orderBy: "createdAt");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await LocalDB.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

   static Future<void> deleteItem(int id) async {
    final db = await LocalDB.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      if (kDebugMode) {
        print("Something went wrong when deleting an item: $err");
      }
    }
  }
}
