import 'package:flutter_shit_app/model/item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('flutter.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE items(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      code INTEGER NOT NULL,
      label TEXT NOT NULL,
      quantity REAL NOT NULL,
      category TEXT NOT NULL,
      availability TEXT NOT NULL,
      salesType TEXT NOT NULL
    )
    ''');
  }

  Future<int> insertItem(Item item) async {
    Database db = await instance.database;
    return await db.insert('items', item.toMap());
  }

  Future<List<Item>> getAllItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('items');

    return List.generate(maps.length, (i) {
      return Item(
        id: maps[i]['id'],
        code: maps[i]['code'],
        label: maps[i]['label'],
        quantity: maps[i]['quantity'],
        category: maps[i]['category'],
        availability: maps[i]['availability'],
        salesType: maps[i]['salesType'],
      );
    });
  }

  // Additional CRUD methods can be defined here

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
