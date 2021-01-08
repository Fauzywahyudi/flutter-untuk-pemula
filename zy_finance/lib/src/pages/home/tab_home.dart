import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zy_finance/src/config/router.gr.dart';
import 'package:zy_finance/src/db/DbHelper.dart';
import 'package:zy_finance/src/model/transaksi.dart';
import 'package:zy_finance/src/model/user.dart';
import 'package:zy_finance/src/provider/home_provider.dart';
import 'package:zy_finance/src/provider/transaksi_provider.dart';
import 'package:zy_finance/src/theme/box_decoration.dart';
import 'package:zy_finance/src/theme/text.dart';
import 'package:zy_finance/src/validation/transaksi_validation.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TransaksiProvider>(
            lazy: true, create: (_) => TransaksiProvider()),
        // ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
      ],
      child: Scaffold(
        floatingActionButton: Consumer<TransaksiProvider>(
          builder: (context, state, _) {
            return FloatingActionButton(
              onPressed: () => showDialog(
                barrierDismissible: false,
                context: context,
                child: DialogTransaksi(title: 'Add Transaction'),
              ).then((value) => state.refreshData()),
              child: Icon(Icons.add),
            );
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Consumer<TransaksiProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.Loading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state.state == ResultState.HasData) {
                      return HomeDecor(
                        user: state.user,
                      );
                    } else if (state.state == ResultState.NoData) {
                      return Center(child: Text(state.message));
                    } else if (state.state == ResultState.Error) {
                      return Center(child: Text(state.message));
                    } else {
                      return Center(child: Text(''));
                    }
                  },
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height -
                    (200 + (kToolbarHeight)),
                width: MediaQuery.of(context).size.width,
                child: Consumer<TransaksiProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.Loading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state.state == ResultState.HasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.result.length,
                        itemBuilder: (context, index) {
                          return ItemData(transaksi: state.result[index]);
                        },
                      );
                    } else if (state.state == ResultState.NoData) {
                      return Center(child: Text(state.message));
                    } else if (state.state == ResultState.Error) {
                      return Center(child: Text(state.message));
                    } else {
                      return Center(child: Text(''));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemData extends StatelessWidget {
  final Transaksi transaksi;

  const ItemData({this.transaksi});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: transaksi.tipe == 'Income'
          ? Icon(
              Icons.keyboard_arrow_down,
              color: Colors.green,
            )
          : Icon(
              Icons.keyboard_arrow_up,
              color: Colors.red,
            ),
      subtitle: Text(transaksi.namaTransaksi),
      title: Text(transaksi.jumlah.toString()),
    );
  }
}

class HomeDecor extends StatelessWidget {
  final User user;

  const HomeDecor({@required this.user});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Center(
          child: Text(
        user == null ? '' : user.nama,
        style: textWhite,
      )),
    );
  }
}

class DialogTransaksi extends StatefulWidget {
  final String title;
  final Transaksi data;

  const DialogTransaksi({@required this.title, this.data});
  @override
  _DialogTransaksiState createState() => _DialogTransaksiState();
}

class _DialogTransaksiState extends State<DialogTransaksi>
    with TransaksiValidation {
  final formKey = GlobalKey<FormState>();
  final dbHelper = DBHelper();
  int valueTipe = 0;
  Transaksi transaksi = Transaksi();
  var tecJumlah = TextEditingController();
  var tecJudul = TextEditingController();
  var tecDeskripsi = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Container(
        decoration: titleDialogDecor,
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            widget.title,
            style: textWhite,
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                controller: tecJumlah,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                decoration: inputDecoration('Jumlah'),
                textAlign: TextAlign.end,
                validator: validateMoney,
                onSaved: (value) {
                  transaksi.jumlah = int.parse(value);
                },
              ),
              SizedBox(height: 10),
              inputTipe(),
              SizedBox(height: 10),
              TextFormField(
                controller: tecJudul,
                decoration: inputDecoration('Judul'),
                validator: validateName,
                onSaved: (value) {
                  transaksi.namaTransaksi = value;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: tecDeskripsi,
                minLines: 1,
                maxLines: 3,
                decoration: inputDecoration('Deskripsi'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        OutlineButton(
          onPressed: () => Router.navigator.pop(),
          child: Text('Cancel'),
        ),
        RaisedButton(
          color: Colors.blueGrey,
          onPressed: !isLoading
              ? () async {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    try {
                      setLoading();
                      transaksi.tanggal = DateTime.now().toIso8601String();
                      if (valueTipe == 0)
                        transaksi.tipe = 'Income';
                      else
                        transaksi.tipe = 'Spend';
                      await dbHelper.createTransaction(transaksi);
                      setLoading();
                      Router.navigator.pop(true);
                    } catch (e) {}
                  }
                }
              : null,
          child: Text(
            'Add',
            style: textWhite,
          ),
        ),
      ],
    );
  }

  void setLoading() => setState(() => isLoading = !isLoading);

  Column inputTipe() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tipe'),
        Row(
          children: [
            Row(
              children: [
                Radio(
                  value: 0,
                  groupValue: valueTipe,
                  onChanged: (v) => setState(() => valueTipe = v),
                ),
                Text('Income'),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: valueTipe,
                  onChanged: (v) => setState(() => valueTipe = v),
                ),
                Text('Spend'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
