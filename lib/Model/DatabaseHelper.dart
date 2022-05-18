import 'dart:io';

import 'package:back_nw/Model/CartModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "Products.db";
  static final _databaseVersion = 1;

  static final table = 'product_table';

  static final id = '_id';
  static final variantId = 'varient_id';
  static final productId = "product_id";
  static final image = 'varient_image';
  static final unit = 'unit';
  static final baseMrp = "base_mrp";
  static final basePrice = "base_price";
  static final productVariantName = "product_varient_name";

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;
    else {
      _database = await _initDatabase();
      return _database;
    }
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $id INTEGER PRIMARY KEY,
            $variantId TEXT NOT NULL,
            $image TEXT NOT NULL,
            $productId TEXT NOT NULL,
            $unit TEXT NOT NULL,
            $baseMrp TEXT NOT NULL,
            $basePrice TEXT NOT NULL,
            $productVariantName TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<CartModel>> getProducts() async {
    var dbHelper = await instance.database;
    List<Map> maps = await dbHelper.query(table, columns: [
      baseMrp,
      image,
      productVariantName,
      basePrice,
      unit,
      productId,
      variantId
    ]);
    List<CartModel> product = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        product.add(CartModel.fromMap(maps[i]));
      }
    }
    return product;
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[variantId];
    return await db
        .update(table, row, where: '$variantId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db
        .delete(table, where: '$variantId = ?', whereArgs: [id]);
  }
}
