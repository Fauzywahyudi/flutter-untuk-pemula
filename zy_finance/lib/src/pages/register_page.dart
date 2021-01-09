import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zy_finance/src/config/router.gr.dart';
import 'package:zy_finance/src/db/DbHelper.dart';
import 'package:zy_finance/src/model/user.dart';
import 'package:zy_finance/src/provider/shared_preferences.dart';
import 'package:zy_finance/src/validation/user_validation.dart';
import 'package:zy_finance/src/widget/box.dart';
import 'package:zy_finance/src/widget/logo.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with UserValidation {
  final formKey = GlobalKey<FormState>();

  var _tecName = TextEditingController();
  var _tecPassword = TextEditingController();
  var _tecMoney = TextEditingController();

  var _focName = FocusNode();
  var _focPassword = FocusNode();
  var _focMoney = FocusNode();

  String _name;
  String _password;
  String _money;

  bool _isLoading = false;

  @override
  void dispose() {
    _tecName.dispose();
    _tecPassword.dispose();
    _tecMoney.dispose();
    _focName.dispose();
    _focPassword.dispose();
    _focMoney.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 50),
              LogoApp(
                height: 150,
                width: 150,
              ),
              SizedBox(height: 30),
              Text(
                'Register Account',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'McLaren',
                ),
              ),
              SizedBox(height: 30),
              FillTextField(
                child: TextFormField(
                  controller: _tecName,
                  focusNode: _focName,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    hintText: 'Your Name',
                    border: InputBorder.none,
                  ),
                  onEditingComplete: () =>
                      FocusScope.of(context).requestFocus(_focPassword),
                  validator: validateName,
                  onSaved: (value) {
                    _name = value;
                  },
                ),
              ),
              FillTextField(
                child: TextFormField(
                  controller: _tecPassword,
                  focusNode: _focPassword,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: InputBorder.none,
                  ),
                  onEditingComplete: () =>
                      FocusScope.of(context).requestFocus(_focMoney),
                  validator: (value) => validatePassword(value, _tecName.text),
                  onSaved: (value) {
                    _password = value;
                  },
                ),
              ),
              FillTextField(
                child: TextFormField(
                  controller: _tecMoney,
                  focusNode: _focMoney,
                  decoration: InputDecoration(
                    hintText: 'Current Money',
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  ],
                  onEditingComplete: () => _focMoney.unfocus(),
                  validator: validateMoney,
                  onSaved: (value) {
                    _money = value;
                  },
                ),
              ),
              SizedBox(height: 30),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                onPressed: _isLoading ? null : onRegister,
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        'Register',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                color: Colors.red,
                height: 50,
                minWidth: MediaQuery.of(context).size.width - 40,
              )
            ],
          ),
        ),
      ),
    );
  }

  void onRegister() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      setLoading();
      final user = User(nama: _name, uang: int.parse(_money), pass: _password);
      final db = DBHelper();
      final result = await db.crateUser(user);
      if (result != null) {
        final dataShared = DataShared();
        dataShared.setUser(user);
        dataShared.setIsNew(false);
        Router.navigator.pushReplacementNamed(Router.homePage);
      } else {
        print('gagal');
      }
      setLoading();
    }
  }

  void setLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }
}
