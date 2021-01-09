import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zy_finance/src/db/tb_debit.dart';
import 'package:zy_finance/src/db/tb_transaksi.dart';
import 'dart:io' as io;
import 'dart:async';

import 'package:zy_finance/src/db/tb_user.dart';
import 'package:zy_finance/src/model/debit.dart';
import 'package:zy_finance/src/model/transaksi.dart';
import 'package:zy_finance/src/model/user.dart';
import 'package:zy_finance/src/provider/shared_preferences.dart';

class DBHelper {
  static final DBHelper _instance = new DBHelper.internal();
  DBHelper.internal();

  factory DBHelper() => _instance;

  static Database _db;

  // database name
  static const nmDb = "mydb";
  final dataShared = DataShared();

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await setDB();
    return _db;
  }

  setDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, nmDb);
    var dB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return dB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(TableUser.createTable);
    await db.execute(TableTransaksi.createTable);
    await db.execute(TableDebit.createTable);
    print("DB Created");
  }

  Future<User> crateUser(User user) async {
    final dbClient = await db;
    user.idUser = await dbClient.insert(TableUser.tbName, user.toJson(),
        nullColumnHack: TableUser.id);
    return user;
  }

  Future<List<Transaksi>> getAllTrasaction() async {
    final dbClient = await db;
    final idUser = await dataShared.getId();
    List<Map<String, dynamic>> results = await dbClient.query(
        TableTransaksi.tbName,
        where: '${TableUser.id} = ?',
        whereArgs: [idUser],
        orderBy: '${TableTransaksi.id} DESC');

    return results.map((res) => Transaksi.fromMap(res)).toList();
  }

  Future<Transaksi> createTransaction(Transaksi transaksi) async {
    final dbClient = await db;
    final idUser = await dataShared.getId();
    final user = await getUserById();
    if (transaksi.tipe == 'Income')
      user.uang += transaksi.jumlah;
    else
      user.uang -= transaksi.jumlah;
    transaksi.idUser = idUser;
    transaksi.idTransaksi =
        await dbClient.insert(TableTransaksi.tbName, transaksi.toJson());
    await updateUang(user);
    return transaksi;
  }

  Future<User> getUserById() async {
    final dbClient = await db;
    final idUser = await dataShared.getId();
    List<Map<String, dynamic>> results = await dbClient.query(
      TableUser.tbName,
      where: '${TableUser.id} = ?',
      whereArgs: [idUser],
    );
    return results.map((res) => User.fromJson(res)).first;
  }

  Future updateUang(User user) async {
    final dbClient = await db;
    final idUser = await dataShared.getId();
    await dbClient.update(
      TableUser.tbName,
      user.toJson(),
      where: '${TableUser.id} = ?',
      whereArgs: [idUser],
    );
  }

  //debt
  Future<List<Debt>> getAllDebt() async {
    final dbClient = await db;
    final idUser = await dataShared.getId();
    List<Map<String, dynamic>> results = await dbClient.query(TableDebit.tbName,
        where: '${TableUser.id} = ?',
        whereArgs: [idUser],
        orderBy: '${TableDebit.id} DESC');

    return results.map((res) => Debt.fromJson(res)).toList();
  }
}
