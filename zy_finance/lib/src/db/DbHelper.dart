import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zy_finance/src/db/tb_transaksi.dart';
import 'dart:io' as io;
import 'dart:async';

import 'package:zy_finance/src/db/tb_user.dart';
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

  // Future<User> getAllUser() async {
  //   final dbClient = await db;
  //   final idUser = await dataShared.getId();
  //   List<Map<String, dynamic>> results = await dbClient.query(
  //     TableUser.tbName,
  //   );
  //   for (var item in results) {
  //     User user = User.fromJson(item);
  //     print(user.toJson());
  //   }

  //   return results.map((res) => User.fromJson(res)).first;
  // }

  // Future<int> saveUser(Myfinance myfinance) async{
  //   var dbClient = await  db;
  //   int res = await dbClient.insert(tb_user, myfinance.toMap());
  //   print("user inserted");
  //   return res;
  // }

  // Future<int> saveIncome(incomeAdap incomeadap) async{
  //   var dbClient = await  db;
  //   int res = await dbClient.insert(tb_income, incomeadap.toMap());
  //   print("income inserted");
  //   return res;
  // }

  // Future<int> saveSpend(spendAdap spendadap) async{
  //   var dbClient = await  db;
  //   int res = await dbClient.insert(tb_spend, spendadap.toMap());
  //   print("spend inserted");
  //   return res;
  // }

  // Future<bool> saveHutang(String type, String nama, double jumlah,String ket,String tgl, String tgl_bayar ) async{
  //   var dbClient = await db;
  //   String status = "0";
  //   List<Map> data = await dbClient.rawQuery("SELECT $_id FROM $type ORDER BY $_id desc");
  //   int id;
  //   if(data.isEmpty){
  //     id = 1;
  //   }else{
  //     id = data[0][_id]+1;
  //   }
  //   print(id.toString());
  //   int res = await dbClient.rawUpdate("INSERT INTO $type VALUES('$id','$nama','$jumlah','$ket','$status','$tgl','$tgl_bayar','0')",);
  //   if(type=="hutang"){
  //     plus_uang(jumlah);
  //     List<Map> datains = await dbClient.rawQuery("SELECT $_id FROM $tb_income ORDER BY $_id desc");
  //     int idins;
  //     if(datains.isEmpty){
  //       idins = 1;
  //     }else{
  //       idins = datains[0][_id]+1;
  //     }
  //     int ins = await dbClient.rawUpdate("INSERT INTO $tb_income VALUES('$idins','Hutang ke $nama','$jumlah','$ket','$tgl')");
  //   }else if(type=="piutang"){
  //     minus_uang(jumlah);
  //     List<Map> datains = await dbClient.rawQuery("SELECT $_id FROM $tb_spend ORDER BY $_id desc");
  //     int idins;
  //     if(datains.isEmpty){
  //       idins = 1;
  //     }else{
  //       idins = datains[0][_id]+1;
  //     }
  //     int ins = await dbClient.rawUpdate("INSERT INTO $tb_spend VALUES('$idins','Piutang ke $nama','$jumlah','$ket','$tgl')");
  //   }
  //   print("$type saved");
  //   return res > 0 ? true : false;
  // }

  // Future<int> deleteIncome(int id) async{
  //   var dbclient = await db;
  //   int res = await dbclient.rawDelete("DELETE FROM $tb_income WHERE id= $id",);
  //   return res;
  // }

  // Future<int> deleteSpend(int id) async{
  //   var dbclient = await db;
  //   int res = await dbclient.rawDelete("DELETE FROM $tb_spend WHERE id= $id",);
  //   return res;
  // }

  // Future<List<Myfinance>> getNote() async {
  //   var dbClient = await db;
  //   List<Map> list = await dbClient.rawQuery("SELECT * FROM user");
  //   List<Myfinance> userdata = new List();
  //   for(int i=0; i < list.length; i++){
  //     var note = new Myfinance(list[i]['nama'],list[i]['password'],list[i]['uang'],list[i]['hutang'],list[i]['piutang'],list[i]['status']);
  //     note.setNoteId(list[i]['id']);
  //     userdata.add(note);
  //   }

  //   return userdata;
  // }

  // Future<List> getIncome({String search}) async{

  //   var dbClient = await db;
  //   List<Map> list ;
  //   if(search.isEmpty){
  //     list = await dbClient.rawQuery("SELECT * FROM $tb_income ORDER BY id desc");
  //   }else{
  //     list = await dbClient.rawQuery("SELECT * FROM $tb_income WHERE "
  //         "$_nama LIKE '%$search%' ORDER BY id desc");
  //   }
  //   return list;
  // }

  // Future<List> getSpend({String search}) async{
  //   var dbClient = await db;
  //   List<Map> list ;
  //   if(search.isEmpty){
  //     list = await dbClient.rawQuery("SELECT * FROM $tb_spend ORDER BY id desc");
  //   }else{
  //     list = await dbClient.rawQuery("SELECT * FROM $tb_spend WHERE "
  //         "$_nama LIKE '%$search%' ORDER BY id desc");
  //   }
  //   return list;
  // }

  // Future<List> getHutang({String search}) async{
  //   var dbClient = await db;
  //   List<Map> list;
  //   if(search.isEmpty){
  //     list = await dbClient.rawQuery("SELECT * FROM $tb_hutang ORDER BY id desc");
  //   }else{
  //     list = await dbClient.rawQuery("SELECT * FROM $tb_hutang WHERE "
  //         "$_nama LIKE '%$search%' ORDER BY id desc");
  //   }
  //   return list;
  // }

  // Future<List> getPiutang({String search}) async{
  //   var dbClient = await db;
  //   List<Map> list;
  //   if(search.isEmpty){
  //     list = await dbClient.rawQuery("SELECT * FROM $tb_piutang ORDER BY id desc");
  //   }else{
  //     list = await dbClient.rawQuery("SELECT * FROM $tb_piutang WHERE "
  //         "$_nama LIKE '%$search%' ORDER BY id desc");
  //   }
  //   return list;
  // }

  // Future<int> getSumHutang(String type) async{
  //   var dbClient = await db;
  //   List<Map> list = await dbClient.rawQuery("SELECT SUM($_jumlah) as jum FROM $type WHERE $_status=0");
  //   int jum = list[0]['jum'];
  //   if(jum==null){
  //     jum = 0;
  //   }
  //   return jum;
  // }

  // Future<int> bayarHutang(int id)async{
  //   var dbClient = await db;
  //   DateTime date = new DateTime.now();
  //   print(date.toString());
  //   int res = await dbClient.rawUpdate("UPDATE $tb_hutang set $_status='1' , $_tgl_lunas='${date.toString()}' WHERE $_id='$id' ");
  //   return res;
  // }

  // Future<int> bayarPiutang(int id)async{
  //   var dbClient = await db;
  //   DateTime date = new DateTime.now();
  //   int res = await dbClient.rawUpdate("UPDATE $tb_piutang set $_status='1' , $_tgl_lunas='${date.toString()}' WHERE $_id='$id' ");
  //   return res;
  // }

  // Future<int> plus_uang(double uang)async{
  //   var dbClient = await db;
  //   int res = await dbClient.rawUpdate("UPDATE $tb_user set uang = uang + $uang WHERE id=1",);
  //   print('update uang');
  // }

  // Future<int> minus_uang(double uang)async{
  //   var dbClient = await db;
  //   int res = await dbClient.rawUpdate("UPDATE $tb_user set uang = uang - $uang WHERE id=1",);
  //   print('update uang');
  // }

  // Future<int> cekUser() async{
  //   var dbclient = await db;
  //   int res = Sqflite
  //       .firstIntValue(await dbclient.rawQuery('SELECT COUNT(*) FROM user'));
  //   return res;
  // }

  // Future<List> cekPass() async{
  //   var dbclient = await db;
  //   List<Map> list = await dbclient.rawQuery("SELECT password,status FROM user");
  //   return list;
  // }

  // Future<List> semuaData() async{
  //   var dbclient = await db;
  //   List<Map> list = await dbclient.rawQuery("SELECT * FROM user");
  //   return list;
  // }

  // Future<bool> setstatusPass(int num) async{
  //   var dbClient = await db;
  //   int res = await dbClient.rawUpdate("UPDATE $tb_user set status=$num WHERE id=1",);
  //   return res > 0 ? true : false;
  // }

  // Future<bool> clearTblUser() async{
  //   var dbClient = await db;
  //   int res = await dbClient.rawUpdate("DELETE FROM $tb_user",);
  //   res = await dbClient.rawUpdate("DELETE FROM $tb_income",);
  //   res = await dbClient.rawUpdate("DELETE FROM $tb_spend",);
  //   res = await dbClient.rawUpdate("DELETE FROM $tb_hutang",);
  //   res = await dbClient.rawUpdate("DELETE FROM $tb_piutang",);
  //   return res > 0 ? true : false;
  // }

  // Future<bool> droptable() async{
  //   var dbClient = await db;
  //   int res = await dbClient.rawUpdate("DROP TABLE $tb_user",);
  //   res = await dbClient.rawUpdate("DROP TABLE $tb_income",);
  //   res = await dbClient.rawUpdate("DROP TABLE $tb_spend",);
  //   res = await dbClient.rawUpdate("DROP TABLE $tb_hutang",);
  //   res = await dbClient.rawUpdate("DROP TABLE $tb_piutang",);
  //   res = await dbClient.rawUpdate("DROP TABLE $tb_quotes",);
  //   return res > 0 ? true : false;
  // }

  // Future<int> createBank(String nm_bank, String no_rek, String cabang, int jumlah)async{
  //   var dbClient = await db;
  //   int res = await dbClient.rawUpdate("INSERT INTO $tb_bank ($_id, $_nm_bank, $_no_rek, $_cabang, $_jumlah)"
  //       "VALUES (null, '$nm_bank', '$no_rek', '$cabang', '$jumlah')");
  //   return res;
  // }

  // Future<List> getBank()async{
  //   var dbClient = await db;
  //   List<Map> list = await dbClient.rawQuery("SELECT * FROM $tb_bank");
  //   return list;
  // }

  // Future<int> deleteBank(int id)async{
  //   var dbcClient = await db;
  //   int res = await dbcClient.rawUpdate("DELETE FROM $tb_bank WHERE $_id='$id'");
  //   return res;
  // }
}
