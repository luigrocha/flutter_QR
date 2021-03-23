import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr/src/models/scan_model.dart';
export 'package:qr/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async {
    // Path de donde almacenamos el bd

    Directory documentDirectory = await getApplicationDocumentsDirectory();

    // path raro

    final path = join(documentDirectory.path, 'ScansDB.db');

    print(path);

    //Crear base de datos

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
          ''');
    });
  }

  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    final db = await database;

    final res = await db.rawInsert('''
    INSERT INTO Scans (id, tipo , valor)
    VALUES($id, '$tipo', '$valor')
    ''');

    return res;
  }

  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    print(res);

    // res es el id del ultimo registro ingresado
    return res;
  }

  Future<ScanModel> getScandById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id =?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getAllScand() async {
    final db = await database;
    final res = await db.query('Scans');

    return res.isNotEmpty
        ? res.map((s) => ScanModel.fromJson(s)).toList()
        : null;
  }

  Future<List<ScanModel>> getAllScandByType(String tipo) async {
    final db = await database;
    final res = await db.rawQuery('''
    SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');

    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }
}
