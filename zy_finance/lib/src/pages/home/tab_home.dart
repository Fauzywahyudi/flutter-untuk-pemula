import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zy_finance/src/config/router.gr.dart';
import 'package:zy_finance/src/model/transaksi.dart';
import 'package:zy_finance/src/model/user.dart';
import 'package:zy_finance/src/provider/transaksi_provider.dart';
import 'package:zy_finance/src/theme/box_decoration.dart';
import 'package:zy_finance/src/theme/text.dart';
import 'package:zy_finance/src/util/my_date_format.dart';
import 'package:zy_finance/src/widget/dialog.dart';
import 'package:countup/countup.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TransaksiProvider>(
      create: (_) => TransaksiProvider(),
      lazy: true,
      child: Scaffold(
        floatingActionButton: Consumer<TransaksiProvider>(
          builder: (context, state, _) {
            return FloatingActionButton(
              onPressed: () => myAnimationDialog(
                context,
                DialogTransaksi(title: 'Add Transaction'),
              ).then((value) =>
                  value == null ? print('no change') : state.refreshData()),
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
                    if (state.homeState == HomeState.Loading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state.homeState == HomeState.HasData) {
                      return HomeDecor(
                        user: state.user,
                        begin: state.beginMoney,
                        end: state.endMoney,
                      );
                    } else if (state.homeState == HomeState.NoData) {
                      return Center(child: Text(state.message));
                    } else if (state.homeState == HomeState.Error) {
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
                        padding:
                            EdgeInsets.only(bottom: 50, left: 10, right: 10),
                        physics: BouncingScrollPhysics(),
                        itemCount: state.result.length,
                        itemBuilder: (context, index) {
                          return ItemData(transaksi: state.result[index]);
                        },
                      );
                    } else if (state.state == ResultState.NoData) {
                      return Center(
                        child: Text(state.message, style: emptyStyle),
                      );
                    } else if (state.state == ResultState.Error) {
                      return Center(
                        child: Text(state.message, style: emptyStyle),
                      );
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

  ItemData({this.transaksi});

  final f = NumberFormat.currency(name: 'Rp ', decimalDigits: 0);
  final myFormat = MyDateFormat();
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(transaksi.tanggal);
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);
    return Card(
      child: ListTile(
        leading: transaksi.tipe == 'Income' ? iconIncome : iconSpend,
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(transaksi.namaTransaksi),
            Text(myFormat.myDifferenceDate(difference)
                // myFormat.myFullDateTime(DateTime.parse(transaksi.tanggal))
                ),
          ],
        ),
        title: Text(
          f.format(transaksi.jumlah),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: transaksi.tipe == 'Income' ? Colors.green : Colors.red,
          ),
        ),
        onTap: () => showDialog(
          context: context,
          barrierDismissible: false,
          child: DetailTransaksi(transaksi: transaksi),
        ),
      ),
    );
  }
}

class HomeDecor extends StatelessWidget {
  final User user;
  final double begin;
  final double end;

  HomeDecor({@required this.user, this.begin, this.end});

  final f = NumberFormat.currency(name: 'Rp ', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: flexSpaceDecor,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user == null ? '' : user.nama,
            style: titleAppStyle,
          ),
          SizedBox(height: 20),
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                      Text(
                        'Rp. ',
                        style: moneyStyle,
                      ),
                      user == null
                          ? Text('0', style: moneyStyle)
                          : Countup(
                              begin: begin,
                              end: end,
                              duration: Duration(milliseconds: 500),
                              separator: ',',
                              style: moneyStyle,
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DetailTransaksi extends StatelessWidget {
  final Transaksi transaksi;

  DetailTransaksi({@required this.transaksi});
  final f = NumberFormat.currency(name: 'Rp ', decimalDigits: 0);
  final myFormat = MyDateFormat();

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
            'Detail Transaction',
            style: textWhite,
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                f.format(transaksi.jumlah),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color:
                        transaksi.tipe == 'Income' ? Colors.green : Colors.red),
              ),
              leading: transaksi.tipe == 'Income' ? iconIncome : iconSpend,
            ),
            ListTile(
              title: Text(transaksi.namaTransaksi),
              subtitle: Text('Title'),
            ),
            ListTile(
              title: Text(
                  transaksi.keterangan == null ? '-' : transaksi.keterangan),
              subtitle: Text('Description'),
            ),
            ListTile(
              title: Text(
                  myFormat.myFullDateTime(DateTime.parse(transaksi.tanggal))),
              subtitle: Text('Transaction Date'),
            ),
          ],
        ),
      ),
      actions: [
        RaisedButton(
          color: Colors.blueGrey,
          onPressed: () => Routes.navigator.pop(),
          child: Text(
            'OK',
            style: textWhite,
          ),
        ),
      ],
    );
  }
}
