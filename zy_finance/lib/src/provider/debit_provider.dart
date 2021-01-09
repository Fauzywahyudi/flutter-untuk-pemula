import 'package:flutter/material.dart';
import 'package:zy_finance/src/db/DbHelper.dart';
import 'package:zy_finance/src/model/debit.dart';

enum DebtState { Loading, NoData, HasData, Error }

class DebitProvider extends ChangeNotifier {
  DebitProvider() {
    fetchData();
  }

  final dbHelper = DBHelper();
  List<Debt> _dataResult;
  String _message = '';
  DebtState _state;
  bool _isDebt = true;

  List<Debt> get result => _dataResult;
  String get message => _message;
  DebtState get state => _state;
  bool get isDebt => _isDebt;

  void refresh() {
    fetchData();
  }

  Future<dynamic> fetchData() async {
    try {
      _state = DebtState.Loading;
      notifyListeners();
      final data = await dbHelper.getAllDebt();
      if (data.isEmpty) {
        _state = DebtState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = DebtState.HasData;
        notifyListeners();
        return _dataResult = data;
      }
    } catch (e) {
      _state = DebtState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
