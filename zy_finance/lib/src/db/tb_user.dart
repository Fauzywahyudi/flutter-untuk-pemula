import 'package:sqflite/sqflite.dart';
import 'package:zy_finance/src/db/DbHelper.dart';
import 'package:zy_finance/src/provider/user_provider.dart';

class TableUser {
  static const tbName = 'user';
  static const id = 'id_user';
  static const nama = 'nama';
  static const pass = 'pass';
  static const uang = 'uang';
  static const hutang = 'hutang';
  static const piutang = 'piutang';
  static const status = 'status';

  //status
  static const online = 'online';
  static const offline = 'offline';

  static const createTable = "CREATE TABLE $tbName($id INTEGER PRIMARY KEY, "
      "$nama TEXT, "
      "$pass TEXT, "
      "$uang INTEGER, "
      "$hutang INTEGER,"
      "$piutang INTEGER, "
      "$status INTEGER)";

  Future<UserState> getUser() async {
    final dbClient = await DBHelper().db;
    final resultOnline = Sqflite.firstIntValue(await dbClient
        .rawQuery("SELECT COUNT(*) FROM $tbName WHERE $status='$online'"));
    final resultOffline = Sqflite.firstIntValue(await dbClient
        .rawQuery("SELECT COUNT(*) FROM $tbName WHERE $status='$online'"));

    if (resultOnline == 1) {
      return UserState.Online;
    } else if (resultOffline == 1) {
      return UserState.Offline;
    } else {
      return UserState.NoData;
    }
  }
}
