import 'package:heavy2022/models/CartProduct.dart';
import 'package:heavy2022/models/Product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabase {
  static final CartDatabase instance = CartDatabase._init();

  static Database? _database;

  CartDatabase._init();

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
  }

  Future<CartProduct> create (CartProduct cartProduct) async {
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
    
    if(maps.isNotEmpty){
      return CartProduct.fromJson(maps.first);
    }
    else{
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

  Future<int> update(CartProduct cartProduct) async {
    final db = await instance.database;

    return db.update(
      tableCartProduct,
      cartProduct.toJson(),
      where: '${CartProductFields.id} = ?',
      whereArgs: [cartProduct.id],
    );
  }

  Future<int> delete(int id) async{
    final db = await instance.database;

    return await db.delete(
      tableCartProduct,
      where: '${CartProductFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
