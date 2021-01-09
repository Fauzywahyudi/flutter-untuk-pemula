import 'package:flutter/material.dart';
import 'package:zy_finance/src/db/DbHelper.dart';
import 'package:zy_finance/src/model/transaksi.dart';
import 'package:zy_finance/src/model/user.dart';

enum ResultState { Loading, NoData, HasData, Error }
enum HomeState { Loading, NoData, HasData, Error }

class TransaksiProvider extends ChangeNotifier {
  TransaksiProvider() {
    fetchData();
    fetchDataStatus();
  }

  final dbHelper = DBHelper();
  String _message = '';
  ResultState _state;
  HomeState _homeState;
  List<Transaksi> _dataResult;
  User _user;
  double _beginMoney = 0;
  double _endMoney = 0;

  String get message => _message;
  ResultState get state => _state;
  HomeState get homeState => _homeState;
  List<Transaksi> get result => _dataResult;
  User get user => _user;
  double get beginMoney => _beginMoney;
  double get endMoney => _endMoney;

  void refreshData() {
    fetchData();
    fetchDataStatus();
  }

  Future<dynamic> fetchData() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final data = await dbHelper.getAllTrasaction();
      if (data.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _dataResult = data;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> fetchDataStatus() async {
    try {
      _homeState = HomeState.Loading;
      notifyListeners();
      final data = await dbHelper.getUserById();
      if (data == null) {
        _homeState = HomeState.NoData;
        notifyListeners();
        print('tak dapat');
        return _message = 'Empty Data';
      } else {
        _homeState = HomeState.HasData;
        notifyListeners();
        _beginMoney = _endMoney;
        _endMoney = double.parse(data.uang.toString());
        print('dapat');
        return _user = data;
      }
    } catch (e) {
      _homeState = HomeState.Error;
      print(e);
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
