import 'package:flutter/material.dart';
import 'package:zy_finance/src/db/DbHelper.dart';
import 'package:zy_finance/src/model/transaksi.dart';

enum HomeState { Loading, NoData, HasData, Error }

class HomeProvider extends ChangeNotifier {
  final dbHelper = DBHelper();
  String _message = '';
  // String _query = '';
  HomeState _state;
  List<Transaksi> _dataResult;

  String get message => _message;
  // String get query => _query;
  HomeState get state => _state;
  List<Transaksi> get result => _dataResult;

  Future<dynamic> _fetchData() async {
    try {
      _state = HomeState.Loading;
      notifyListeners();
      final data = await dbHelper.getAllTrasaction();
      if (data.isEmpty) {
        _state = HomeState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = HomeState.HasData;
        notifyListeners();
        return _dataResult = data;
      }
    } catch (e) {
      _state = HomeState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
