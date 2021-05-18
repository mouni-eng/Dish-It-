import 'package:final_project2/Models/lastOrders_model.dart';
import 'package:final_project2/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class OrderDatabase {
  OrderDatabase._();
  static final OrderDatabase db = OrderDatabase._();
  static Database _orderDatabase;
  Future<Database> get orderDatabase async {
    if (_orderDatabase != null) {
      return _orderDatabase;
    } else {
      _orderDatabase = await initDb2();
      return _orderDatabase;
    }
  }

  initDb2() async {
    String path = join(await getDatabasesPath(), 'order.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE $tableOrder($tableOrderPic TEXT, $tableOrderprId TEXT, $tableUsername TEXT, $tableUserlastName TEXT, $tableUserphoneNumber TEXT, $tableUseraddress TEXT, $tabletotalPrice TEXT)");
    });
  }


  insert2(LastOrderModel model) async {
    var dbClient = await orderDatabase;
    await dbClient.insert(tableOrder, model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map>> getallOrders() async {
    var dbClient = await orderDatabase;
    List<Map> listOfMaps = await dbClient.query(tableOrder);
    return listOfMaps;
  }

}