import 'package:final_project2/Models/cart_model.dart';
import 'package:final_project2/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabase {
  CartDatabase._();
  static final CartDatabase db = CartDatabase._();
  static Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDb();
      return _database;
    }
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'cart.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE $tableCart($tableCartName TEXT, $tableCartPic TEXT, $tableCartPrice TEXT, $tableCartid TEXT, $tableCartQuantity INTEGER)");
    });
  }


  insert(CartModel model) async {
    var dbClient = await database;
    await dbClient.insert(tableCart, model.tojson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map>> getallProducts() async {
    var dbClient = await database;
    List<Map> listOfMaps = await dbClient.query(tableCart);
    return listOfMaps;
  }

  Future<void> updateCart(CartModel model) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      tableCart,
      model.tojson(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [model.id],
    );
  }

  Future<void> deleteDog(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the Database.
    await db.delete(
      '$tableCart',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
