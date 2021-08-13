import 'package:final_project2/Models/product_model.dart';
import 'package:final_project2/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FavouriteDatabase {
  FavouriteDatabase._();
  static final FavouriteDatabase db = FavouriteDatabase._();
  static Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDb2();
      return _database;
    }
  }

  initDb2() async {
    String path = join(await getDatabasesPath(), 'Fav.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE $favTable($title TEXT, $description TEXT, $id INTEGER, $price TEXT, $images TEXT, $rating TEXT, $vendor TEXT, $logo TEXT, $deleivery TEXT, $deleiveryTime TEXT)");
    });
  }

  insert(Product model) async {
    var dbClient = await database;
    await dbClient.insert(favTable, model.tojson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map>> getallProducts() async {
    var dbClient = await database;
    List<Map> listOfMaps = await dbClient.query(favTable);
    return listOfMaps;
  }

  Future<void> updateCart(Product model) async {
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
      '$favTable',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}