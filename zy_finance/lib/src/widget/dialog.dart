import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zy_finance/src/config/router.gr.dart';
import 'package:zy_finance/src/db/DbHelper.dart';
import 'package:zy_finance/src/model/transaksi.dart';
import 'package:zy_finance/src/theme/box_decoration.dart';
import 'package:zy_finance/src/theme/text.dart';
import 'package:zy_finance/src/validation/transaksi_validation.dart';

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