
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/tv_model.dart';

class BookmarkDb {
  static final BookmarkDb _instance = BookmarkDb._internal();
  factory BookmarkDb() => _instance;
  BookmarkDb._internal();

  static Database? _db;
  static const String _dbName = 'bookmark.db';
  static const String _table = 'favorites';

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _dbName);

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE $_table(
          id INTEGER PRIMARY KEY,
          data TEXT NOT NULL
        )
      ''');
    });
  }

  Future<void> insertFavorite(Tvmodel show) async {
    final dbClient = await db;
    final jsonStr = json.encode(show.toJson());
    await dbClient.insert(
      _table,
      {'id': show.id, 'data': jsonStr},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFavorite(int id) async {
    final dbClient = await db;
    await dbClient.delete(_table, where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> exists(int id) async {
    final dbClient = await db;
    final res = await dbClient.query(_table, columns: ['id'], where: 'id = ?', whereArgs: [id], limit: 1);
    return res.isNotEmpty;
  }

  Future<List<Tvmodel>> getAllFavorites() async {
    final dbClient = await db;
    final rows = await dbClient.query(_table, orderBy: 'id DESC');
    return rows.map((r) {
      final data = r['data'] as String;
      final map = json.decode(data) as Map<String, dynamic>;
      return Tvmodel.fromJson(map);
    }).toList();
  }

  Future<void> clearAll() async {
    final dbClient = await db;
    await dbClient.delete(_table);
  }
}
