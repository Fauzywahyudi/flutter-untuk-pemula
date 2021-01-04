// import 'package:flutter/cupertino.dart';
// import 'package:zy_finance/src/db/tb_user.dart';
// import 'package:zy_finance/src/model/user.dart';

// enum UserState { Online, Offline, NoData, Loading, Error }

// class UserProvider extends ChangeNotifier {
//   final BuildContext context;
//   final tbUser = TableUser();

//   UserProvider(this.context);

//   // final db = DBHelper();
//   UserState _state;
//   User _userResult;
//   String _message = '';

//   UserState get state => _state;
//   User get result => _userResult;
//   String get message => _message;

//   Future<dynamic> getUserState() async {
//     try {
//       _state = UserState.Loading;
//       notifyListeners();
//       final cekUser = await tbUser.getUser();
//       if (cekUser == UserState.NoData) {
//         _state = UserState.NoData;
//         notifyListeners();
//       } else if (cekUser == UserState.Online) {
//         _state = UserState.Online;
//         notifyListeners();
//       } else {
//         _state = UserState.Offline;
//         notifyListeners();
//       }
//     } catch (e) {
//       _state = UserState.Error;
//       notifyListeners();
//       return _message = 'Error --> $e';
//     }
//   }
// }
