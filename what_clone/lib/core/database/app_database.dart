import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  factory AppDatabase() => _instance;
  AppDatabase._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'whatsapp_clone.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // TODO: Create tables
      },
    );
  }

  // Example: Close DB
  Future close() async {
    final db = await database;
    db.close();
  }
} 