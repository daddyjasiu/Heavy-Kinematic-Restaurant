import 'package:heavy2022/models/CartProduct.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/OrderHistory.dart';

class SQFLiteDB {
  static final SQFLiteDB instance = SQFLiteDB._init();

  static Database? _database;

  SQFLiteDB._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB("cart.db");

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final doubleType = 'REAL NOT NULL';

    await db.execute('''
CREATE TABLE $tableCartProduct (
  ${CartProductFields.id} $idType,
  ${CartProductFields.image} $textType,
  ${CartProductFields.title} $textType,
  ${CartProductFields.price} $doubleType,
  ${CartProductFields.description} $textType,
  ${CartProductFields.category} $textType,
  ${CartProductFields.extras} $textType
  )
''');

    await db.execute('''
CREATE TABLE $tableOrderHistory (
  ${CartProductFields.id} $idType,
  ${CartProductFields.image} $textType,
  ${CartProductFields.title} $textType,
  ${CartProductFields.price} $doubleType,
  ${CartProductFields.description} $textType,
  ${CartProductFields.category} $textType,
  ${CartProductFields.extras} $textType
  )
''');
  }

  Future<CartProduct> createCartProduct(CartProduct cartProduct) async {
    final db = await instance.database;

    final id = await db.insert(tableCartProduct, cartProduct.toJson());
    return cartProduct.copy(id: id);
  }

  Future<CartProduct> readCartProductById(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableCartProduct,
      columns: CartProductFields.values,
      where: '${CartProductFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return CartProduct.fromJson(maps.first);
    } else {
      throw Exception("ID $id not found!");
    }
  }

  Future<List<CartProduct>> readCartProducts() async {
    final db = await instance.database;

    final result = await db.query(
      tableCartProduct,
    );
    return result.map((json) => CartProduct.fromJson(json)).toList();
  }

  Future<int> updateCartProduct(CartProduct cartProduct) async {
    final db = await instance.database;

    return db.update(
      tableCartProduct,
      cartProduct.toJson(),
      where: '${CartProductFields.id} = ?',
      whereArgs: [cartProduct.id],
    );
  }

  Future<int> deleteCartProduct(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableCartProduct,
      where: '${CartProductFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllCartProducts() async {
    final db = await instance.database;

    return await db.delete(
      tableCartProduct,
    );
  }

  Future<OrderHistory> createOrderHistory(OrderHistory orderHistory) async {
    final db = await instance.database;

    final id = await db.insert(tableOrderHistory, orderHistory.toJson());
    return orderHistory.copy(id: id);
  }

  Future<OrderHistory> readOrderHistoryById(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableOrderHistory,
      columns: OrderHistoryFields.values,
      where: '${OrderHistoryFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return OrderHistory.fromJson(maps.first);
    } else {
      throw Exception("ID $id not found!");
    }
  }

  Future<List<OrderHistory>> readOrderHistory() async {
    final db = await instance.database;

    final result = await db.query(
      tableOrderHistory,
    );
    return result.map((json) => OrderHistory.fromJson(json)).toList();
  }

  Future<int> updateOrderHistory(OrderHistory orderHistory) async {
    final db = await instance.database;

    return db.update(
      tableOrderHistory,
      orderHistory.toJson(),
      where: '${OrderHistoryFields.id} = ?',
      whereArgs: [orderHistory.id],
    );
  }

  Future<int> deleteOrderHistory(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableOrderHistory,
      where: '${OrderHistoryFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllOrderHistory() async {
    final db = await instance.database;

    return await db.delete(
      tableOrderHistory,
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
